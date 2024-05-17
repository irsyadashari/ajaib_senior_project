import Foundation

let group = DispatchGroup()



func task(_ taskName: String, completion: (()->())) {
    print("doing task: \(taskName)")
    
    sleep(1)
    completion()
}

group.enter()
task("task 1") {
    print("Task 1 is completed")
    group.leave()
}

group.enter()
task("task 2") {
    print("Task 2 is completed")
    group.leave()
}

group.enter()
task("task 3") {
    print("Task 3 is completed")
    group.leave()
}

group.notify(queue: .default) {
    print("all tasks has been done")
}
