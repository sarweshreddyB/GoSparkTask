//
//  LogInRequest.swift
//  GoSpark
//
//  Created by sarwesh reddy on 27/09/19.
//  Copyright © 2019 sarwesh reddy. All rights reserved.
//

import Foundation
struct LogInRequest: Codable {
    let email, password: String
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}

