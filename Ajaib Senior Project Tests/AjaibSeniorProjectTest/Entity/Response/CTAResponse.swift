//
//  CTAResponse.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 11/03/24.
//

import Foundation

struct CTAResponse: Codable {
    let banners: [String]
    
    func toModel() -> CTADomainModel {
        return CTADomainModel(banners: banners)
    }
}
