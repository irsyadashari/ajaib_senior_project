//
//  InvestmentDuration.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 10/03/24.
//

import Foundation

enum InvestmentDuration {
    case sixMonth
    case oneYear
    case threeYear
    case fiveYear
    
    var duration: Double {
        switch self {
        case .sixMonth:
            return 0.5
        case .oneYear:
            return 1
        case .threeYear:
            return 3
        case .fiveYear:
            return 5
        }
    }
}
