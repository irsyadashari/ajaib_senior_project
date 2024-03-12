//
//  StringFormatter.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 11/03/24.
//

import Foundation

final class StringFormatter {
    static func getDisplayedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        let formattedDateString = dateFormatter.string(from: date)
        return formattedDateString
    }
    
    static func getCurrencyText(number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "Rp"
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2

        if let formattedString = numberFormatter.string(from: NSNumber(value: Double(number)/100)) {
            return formattedString
        } else {
            print("Unable to format the number.")
        }
        return "0"
    }
    
    static func getCurrencyDisplayedText(number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "Rp"
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0

        if let formattedString = numberFormatter.string(from: NSNumber(value: Double(number))) {
            return formattedString
        } else {
            print("Unable to format the number.")
        }
        return "0"
    }
    
    static func getDecimalText(number: Double) -> String {
        let formattedString = String(format: "%.3f", number).replacingOccurrences(of: ".", with: ",")
        return formattedString
    }
}
