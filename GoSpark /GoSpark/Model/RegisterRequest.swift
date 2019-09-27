//
//  RegisterRequest.swift
//  GoSpark
//
//  Created by sarwesh reddy on 27/09/19.
//  Copyright © 2019 sarwesh reddy. All rights reserved.
//
import Foundation
struct RegisterRequest: Codable {
    let name, email, password, passwordConfirmation: String
    let mobile, gender: String

    enum CodingKeys: String, CodingKey {
        case name, email, password
        case passwordConfirmation = "password_confirmation"
        case mobile, gender
    }
    func jsonData() throws -> Data {
           return try JSONEncoder().encode(self)
       }
}


