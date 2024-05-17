//
//  UserResponse.swift
//  AjaibSeniorProjectTest
//
//  Created by Muh Irsyad Ashari on 11/03/24.
//

import Foundation

struct UserResponse: Codable {
    let user: UserModelResponse
}

struct UserModelResponse: Codable {
    let name: String
    let isVerified: Bool
    
    enum CodingKeys: String, CodingKey {
        case name
        case isVerified = "is_verified"
    }
    
    func toModel() -> UserDomainModel {
        return UserDomainModel(name: name, isVerified: isVerified)
    }
}
