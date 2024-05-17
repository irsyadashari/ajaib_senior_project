//
//  SimulationResponse.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 09/03/24.
//

import Foundation

struct SimulationResponse: Codable {
    let yearlyProjection: Double
    let investmentDate: String
    let qtyOwned: String
    let marketPrice: String

    enum CodingKeys: String, CodingKey {
        case yearlyProjection = "yearly_projection"
        case investmentDate = "investment_date"
        case qtyOwned = "qty_owned"
        case marketPrice = "market_price"
    }

    // Custom decoding for 'investmentDate' to parse the date from the given format
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        yearlyProjection = try container.decode(Double.self, forKey: .yearlyProjection)
        qtyOwned = try container.decode(String.self, forKey: .qtyOwned)
        marketPrice = try container.decode(String.self, forKey: .marketPrice)
        investmentDate = try container.decode(String.self, forKey: .investmentDate)
       
    }
    
    func toModel() -> SimulationDomainModel {
        // Custom date decoding
        var dateObj = Date()
        if let date = DateFormatter.iso8601withFractionalSeconds.date(from: investmentDate) {
            dateObj = date
        } else {
            print("decoding date error")
        }
        
        let numberQtyDouble = qtyOwned.decimalToDouble()
        let marketPriceDouble = marketPrice.currencyToDouble()
        
        return SimulationDomainModel(
            yearlyProjection: yearlyProjection,
            investmentDate: dateObj,
            qtyOwned: numberQtyDouble,
            marketPrice: marketPriceDouble
        )
    }
}

extension DateFormatter {
    static var iso8601withFractionalSeconds: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
}

extension String {
    func decimalToDouble() -> Double {
        // Replace comma with period and convert to Double
        if let doubleValue = Double(self.replacingOccurrences(of: ",", with: ".")) {
            return doubleValue
        } else {
            print("Unable to convert the string to Double.")
            return 0.0
        }
    }
    
    func currencyToDouble() -> Double {
        // Remove the period, replace the comma with a period, and convert to Double
        if let doubleValue = Double(self.replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: ",", with: ".")) {
            return doubleValue
        } else {
            print("Unable to convert the string to Double.")
            return 0.0
        }
    }
}
