//: [Previous](@previous)

import Foundation

let queue = DispatchQueue(label: "myQueue", attributes: .concurrent)

queue.async {
    print("doing task 1 concurrent")
    sleep(2)
    print("done task 1 concurrent ")
}

queue.async {
    print("doing task 2 concurrent")
    sleep(1)
    print("done task 2 concurrent")
}


let serialQueue = DispatchQueue(label: "Sync-queue")

serialQueue.sync {
    print("doing task 1 serial")
    sleep(2)
    print("done task 1 serial")
}

serialQueue.sync {
    print("doing task 2 serial")
    sleep(1)
    print("done task 2 serial")
}
