//
//  CarouselViewPresenter.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 06/03/24.
//

import Foundation

final class CarouselViewPresenter {
    var colors: [String]
    
    init(colors: [String]) {
        self.colors = colors
    }
    
    func getColors() -> [String] {
        return colors
    }
    
    func getColor(at index: Int) -> String {
        return colors[index]
    }
}
