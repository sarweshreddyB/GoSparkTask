//
//  LogInResponse.swift
//  GoSpark
//
//  Created by sarwesh reddy on 27/09/19.
//  Copyright © 2019 sarwesh reddy. All rights reserved.
//


import Foundation

// MARK: - LogInResponse
struct LogInResponse: Codable {
    let status, message: String?
    let user: User?
    
    init(data: Data) throws {
        self = try JSONDecoder().decode(LogInResponse.self, from: data)
    }
}


// MARK: - User
struct User: Codable {
    let id: Int
    let name, email, emailVerifiedAt, apiToken: String
    let rateLimit: String
    let walletBalance, facebook, google, twitter: Int
    let userType: String
    let deletedAt: String?
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case emailVerifiedAt = "email_verified_at"
        case apiToken = "api_token"
        case rateLimit = "rate_limit"
        case walletBalance = "wallet_balance"
        case facebook, google, twitter
        case userType = "user_type"
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
