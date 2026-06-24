//
//  LoginResponseModel.swift
//  Gate Global
//
//  Created by Poojagabani on 28/04/26.
//

import Foundation

// MARK: - Login Response
struct LoginResponseModel: Codable {
    let success: Bool
    let statusCode: Int
    let message: String
    let data: LoginData?
    let meta: Meta?
    
    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message
        case data
        case meta
    }
}

// MARK: - Login Data
struct LoginData: Codable {
    let user: User?
    let accessToken: String?
    let tokenType: String?
    let expiresAt: String?
    
    enum CodingKeys: String, CodingKey {
        case user
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresAt = "expires_at"
    }
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let firstName: String?
    let middleName: String?
    let lastName: String?
    let email: String?
    let mobileNumber: String?
    let countryCode: String?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case middleName = "middle_name"
        case lastName = "last_name"
        case email
        case mobileNumber = "mobile_number"
        case countryCode = "country_code"
        case status
    }
}

// MARK: - Meta
struct Meta: Codable {
    let requestId: String?
    let timestamp: String?
    let responseTimeMs: Int?
    
    enum CodingKeys: String, CodingKey {
        case requestId = "request_id"
        case timestamp
        case responseTimeMs = "response_time_ms"
    }
}
