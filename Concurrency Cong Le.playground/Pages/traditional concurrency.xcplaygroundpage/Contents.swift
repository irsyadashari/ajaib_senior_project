import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
// This line tells the Playground to continue running indefinitely


// 1. Write Task to be executed in BG Thread
//DispatchQueue.global(qos: .background).async {
//    // Background thread work here
//    print("Running on background thread")
//    
//    // Simulate a network call or heavy computation
//    sleep(1) // Delays the thread for 2 seconds to simulate some work being done
//    
//    // Switch back to the main thread to update the UI
//    DispatchQueue.main.async {
//        // Update UI on the main thread
//        print("Back on the main thread")
//        
//        // This line tells the Playground that we are done and it can stop running
//        PlaygroundPage.current.finishExecution()
//    }
//}

// =======================================================================================

// =======================================================================================

// =======================================================================================









// 2.DeadLock
/*
 A deadlock occurs when two or more threads are waiting on each other to release resources,
 resulting in a standstill. Here’s an illustrative example that could potentially cause a deadlock:
 */

// Create two NSLock objects to demonstrate a deadlock situation
//let lock1 = NSLock()
//let lock2 = NSLock()
//
//// Thread 1
//DispatchQueue.global().async {
//    lock1.lock() // Thread 1 acquires lock1
//    print("Thread 1 acquired lock1")
//    sleep(1) // Sleep to increase the chance that Thread 2 acquires lock2 before Thread 1 attempts to acquire it
//    
//    print("Thread 1 waiting for lock2")
//    lock2.lock() // Thread 1 attempts to acquire lock2, but it's already held by Thread 2
//    print("Thread 1 acquired lock2") // This line will not execute because of the deadlock
//    
//    lock2.unlock() // These unlock calls will not be reached
//    print("lock 2 is unlock")
//    
//    lock1.unlock()
//    print("lock 1 is unlock")
//}
//
//// Thread 2
//DispatchQueue.global().async {
//    lock2.lock() // Thread 2 acquires lock2
//    print("Thread 2 acquired lock2")
//    sleep(1) // Sleep to increase the chance that Thread 1 acquires lock1 before Thread 2 attempts to acquire it
//    
//    print("Thread 2 waiting for lock1")
//    lock1.lock() // Thread 2 attempts to acquire lock1, but it's already held by Thread 1
//    print("Thread 2 acquired lock1") // This line will not execute because of the deadlock
//    lock1.unlock() // These unlock calls will not be reached
//    lock2.unlock()
//}
//
//// The playground will hang here indefinitely due to the deadlock.
//// Normally, you would call PlaygroundPage.current.finishExecution() to stop the Playground,
//// but in this case, it is intentionally left out to demonstrate the deadlock

// =======================================================================================

// =======================================================================================

// =======================================================================================









//3. Race Condition
/*
 A race condition happens when multiple threads access and modify shared data concurrently.
 The final state of the shared data depends on the threads’ execution order, which can be unpredictable:
 */

// Shared resource that will be accessed by multiple threads
//var sharedResource = 0
//
//// Create a concurrent queue to simulate a race condition
//let resourceQueue = DispatchQueue(label: "resourceQueue", attributes: .concurrent)
//
//let locker = NSLock()
//// First asynchronous task to increment the shared resource 1000 times
//resourceQueue.async {
//    for _ in 1...1000 {
//        sharedResource += 1
//    }
//}
//
//// Second asynchronous task to increment the shared resource 1000 times
//resourceQueue.async {
//    for _ in 1...1000 {
//        sharedResource += 1
//    }
//}
//
//// Schedule a task on the main queue to check the final value of the shared resource
//// after a delay, giving enough time for the above tasks to complete
//DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//    // Print the final value of the shared resource
//    print("Final value of sharedResource is: \(sharedResource)")
//    
//    // Stop the playground from running after we have the result
//    PlaygroundPage.current.finishExecution()
//}

// Expected behavior due to the race condition:
// The final value of sharedResource should be 2000 since we're incrementing it 1000 times in each task.
// However, due to the race condition caused by concurrent access to the sharedResource without proper synchronization,
// we may get a different result each time we run this code.
// This is because both tasks might read, increment, and write back the value of sharedResource at the same time,
// leading to some increments being lost. The actual outcome is non-deterministic and varies with each execution.


// =======================================================================================

// =======================================================================================

// =======================================================================================






// 4. MultiThreading With Operation

/*
Multithreading
Multithreading is necessary to perform multiple operations at the same time, such as running background tasks while keeping the user interface responsive. OperationQueue is one way to manage multiple operations:
 */

//let queue = OperationQueue()
//
//let operation1 = BlockOperation {
//    sleep(1)
//    print("op 1 is on progress")
//    
//}
//
//let operation2 = BlockOperation {
//    sleep(2)
//    print("op 2 is on progress")
//}
//
//queue.addOperation(operation1)
//queue.addOperation(operation2)
//
//let completionOperation = BlockOperation {
//    print("all ops has been completed")
//    PlaygroundPage.current.finishExecution()
//}
//
//completionOperation.addDependency(operation1)
//completionOperation.addDependency(operation2)
//
//queue.addOperation(completionOperation)


// 5. Using GCD with Barriers
/*
 When using concurrent queues, you can still synchronize access to shared resources by using barrier blocks. This allows multiple tasks to execute concurrently, but ensures exclusive access when updating shared resources:

*/

// Create a concurrent dispatch queue
//let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)
//
//// Shared resource that will be accessed by multiple tasks on the concurrent queue
//var sharedResource = 0
//
//// First task with a barrier flag to increment the shared resource 1000 times
//concurrentQueue.async(flags: .barrier) {
//    for _ in 1...1000 {
//        sharedResource += 1
//    }
//}
//
//// Second task with a barrier flag to increment the shared resource 1000 times
//concurrentQueue.async(flags: .barrier) {
//    for _ in 1...1000 {
//        sharedResource += 1
//    }
//}
//
//// Schedule a task to check the final value of the shared resource
//// after a delay, giving enough time for the above tasks to complete
//DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//    // Print the final value of the shared resource
//    print("Final value of sharedResource is: \(sharedResource)")
//    
//    // Stop the playground from running after we have the result
//    PlaygroundPage.current.finishExecution()
//}

// Expected behavior:
// The final value of sharedResource should be 2000 since we're incrementing it 1000 times in each task.
// However, using `.barrier` flags with concurrent queues does not prevent race conditions for incrementing operations.
// The barrier flag ensures that the block waits for previously enqueued tasks to complete before executing,
// and subsequent tasks wait for the barrier block to complete.
// In this case, the barrier is not used correctly because the sharedResource is being modified without synchronization.
// The correct use of the barrier flag would be for read-modify-write operations where the write is done within the barrier block.
// Therefore, the actual output of this code may be unpredictable, and the final value may not be 2000 as expected.


















// 6. Using DispatchSemaphore
/*
 A semaphore provides a means to control access to a resource by multiple threads using a counter that tracks the number of available resources:
 */


// Create a DispatchSemaphore with a value of 1, allowing one thread to access the critical section at a time
let semaphore = DispatchSemaphore(value: 1)

// Shared resource that will be accessed by multiple threads
var sharedResource = 0

// First task to increment the shared resource 1000 times
DispatchQueue.global().async {
    for _ in 1...100 {
        semaphore.wait() // Wait for the semaphore to become available before accessing the shared resource
        sharedResource += 1
        print("op 1 : \(sharedResource)")
        semaphore.signal() // Signal that the shared resource is now available for other threads
    }
}

// Second task to increment the shared resource 1000 times
DispatchQueue.global().async {
    for _ in 1...100 {
        semaphore.wait() // Wait for the semaphore to become available before accessing the shared resource
        sharedResource += 1
        print("op 2 : \(sharedResource)")
        semaphore.signal() // Signal that the shared resource is now available for other threads
    }
}

// Schedule a task to check the final value of the shared resource
// after a delay, giving enough time for the above tasks to complete
DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    // Print the final value of the shared resource
    print("Final value of sharedResource is: \(sharedResource)")
    
    // Stop the playground from running after we have the result
    PlaygroundPage.current.finishExecution()
}

// Expected behavior:
// The final value of sharedResource should be 2000 since we're incrementing it 1000 times in each task.
// The DispatchSemaphore ensures that only one thread can modify the shared resource at a time,
// which prevents race conditions. This means that the threads will take turns incrementing the shared resource,
// each thread waiting for the semaphore to be signaled by the other before proceeding with its increments.
// Therefore, each increment is performed safely without any concurrent access issues.
