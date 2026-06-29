//
//  RemoveMemberResponse.swift
//  Pathrium
//
//  Created by Kenil on 29/06/26.
//

import Foundation

// MARK: - Remove Member Response
struct RemoveMemberResponse: Codable {
    let success: Bool?
    let statusCode: Int?
    let message: String?
    let data: RemoveMemberData?
    let meta: Meta?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message
        case data
        case meta
    }
}

// MARK: - Data
struct RemoveMemberData: Codable {
    let removedMember: RemovedMember?
    let shareableType: String?
    let shareableID: Int?

    enum CodingKeys: String, CodingKey {
        case removedMember = "removed_member"
        case shareableType = "shareable_type"
        case shareableID = "shareable_id"
    }
}

// MARK: - Removed Member
struct RemovedMember: Codable {
    let userID: Int?
    let name: String?
    let email: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name
        case email
    }
}

