import Foundation

let queue = OperationQueue()

let operation1 = BlockOperation {
    print("Starting operation 1")
    sleep(3)
    print("finished operation 1")
}

let operation2 = BlockOperation {
    print("Starting operation 2")
    sleep(1)
    print("finished operation 2")
}

queue.addOperation(operation1)
queue.addOperation(operation2)


let completionOperation = BlockOperation {
    print("All Operation is completed")
}

completionOperation.addDependency(operation1)
completionOperation.addDependency(operation2)

queue.addOperation(completionOperation)

//queue.isSuspended = false
