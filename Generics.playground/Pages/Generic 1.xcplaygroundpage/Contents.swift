import UIKit
import Foundation
//https://medium.com/gitconnected/how-to-use-generics-in-swift-3cf2438973fe


//Non Generic Version
//class SearchUtil{
//    var list: [Int] = []
//    
//    init(list: [Int]) {
//        self.list = list
//    }
//    
//    func searchItem(element: Int, foundItem: (Int?)->()) {
//        let itemFoundList = self.list.filter { item in
//            item == element
//        }
//        if (itemFoundList.isEmpty){
//            foundItem(nil)
//        }
//        else{
//            foundItem(itemFoundList.first)
//        }
//    }
//}

//let searchUtil = SearchUtil(list: [Int](arrayLiteral: 24,25,26))
//searchUtil.searchItem(element: 24) { result in
//    print(result != nil ? "Element \(String(describing: result)) is found" : "Not found")
//}






//Generic Class
class SearchUtilGenerics<T: Equatable> {
    var list: [T]
    
    init(list: [T]) {
        self.list = list
    }
    
    func searchItem(element: T) -> T? {
        let item = list.filter {
            $0 == element
        }.first
        if let itemW = item {
            print("Element \(itemW) is found")
        }
       
        return item
    }
}


struct Toy: Equatable {
    let id = UUID()
    let name: String
    let price: Int
    
    static func == (lhs: Toy, rhs: Toy) -> Bool {
        return lhs.name == rhs.name
    }
}

let toys: [Toy] = [
    Toy(name: "Gun", price: 10000),
    Toy(name: "Monopoly", price: 10000),
    Toy(name: "Lego", price: 10000)
]

let searchUtilGenerics = SearchUtilGenerics(list: toys)
searchUtilGenerics.searchItem(element:  Toy(name: "Gun", price: 10000))
