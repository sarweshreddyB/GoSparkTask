//
//  RegisterResponse.swift
//  GoSpark
//
//  Created by sarwesh reddy on 27/09/19.
//  Copyright © 2019 sarwesh reddy. All rights reserved.
//

import Foundation
struct RegisterResponse: Codable {
    let status, message: String?
    init(data: Data) throws {
           self = try JSONDecoder().decode(RegisterResponse.self, from: data)
       }
}
