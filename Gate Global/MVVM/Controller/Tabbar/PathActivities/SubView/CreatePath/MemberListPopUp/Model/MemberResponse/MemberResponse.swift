//
//  MemberResponse.swift
//  Pathrium
//
//  Created by Kenil on 29/06/26.
//

import Foundation

// MARK: - Response
struct MemberResponse: Codable {
    let success: Bool?
    let statusCode: Int?
    let message: String?
    let data: UsersData?
    let meta: Meta?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data, meta
    }
}

// MARK: - Data
struct UsersData: Codable {
    let users: [MemberUser]?
    let total: Int?
}

// MARK: - User
struct MemberUser: Codable {
    let userId: Int?
    let name: String?
    let email: String?
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name
        case email
        case avatar
    }
}

