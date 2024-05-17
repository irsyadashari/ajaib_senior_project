//
//  UIColor+Ext.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 06/03/24.
//

import UIKit

extension String {
    func hexStringToUIColor() -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UIColor {
    static var backgroundContrastColor: UIColor {
        return UIColor { (traits) -> UIColor in
            // Return one of two colors depending on light or dark mode
            return traits.userInterfaceStyle == .dark ?
            UIColor(red: 255, green: 255, blue: 255, alpha: 1) :
            UIColor(red: 0.3, green: 0.4, blue: 0.5, alpha: 1)
        }
    }
}
