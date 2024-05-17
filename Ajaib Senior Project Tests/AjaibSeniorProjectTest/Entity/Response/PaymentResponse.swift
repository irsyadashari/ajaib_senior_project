//
//  PaymentResponse.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 11/03/24.
//

import Foundation

struct PaymentResponse: Codable {
    let payments: PaymentModelResponse
}

struct PaymentModelResponse: Codable {
    let balance: Double
    let inProcessBalance: Double
    
    enum CodingKeys: String, CodingKey {
        case balance
        case inProcessBalance = "in_process_balance"
    }
    
    func toModel() -> PaymentDomainModel {
        return PaymentDomainModel(balance: balance, inProcessBalance: inProcessBalance)
    }
}
