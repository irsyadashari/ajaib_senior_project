//
//  Theme.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 06/03/24.
//

import UIKit

enum Theme: String {
    case light, dark, system

    var uiInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return .unspecified
        }
    }
}
