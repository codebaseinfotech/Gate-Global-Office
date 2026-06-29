//
//  CreateTrackResponse.swift
//  Pathrium
//
//  Created by Kenil on 29/06/26.
//

import Foundation

// MARK: - Response
struct CreateTrackResponse: Codable {
    let success: Bool?
    let statusCode: Int?
    let message: String?
    let data: TrackData?
    let meta: Meta?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data, meta
    }
}

// MARK: - Track Data
struct TrackData: Codable {
    let id: Int?
    let pathId: Int?
    let name: String?
    let description: String?
    let order: Int?
    let colorTagId: Int?
    let createdAt: String?
    let members: [TrackMember]?
    let membersCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, description, order, members
        case pathId = "path_id"
        case colorTagId = "color_tag_id"
        case createdAt = "created_at"
        case membersCount = "members_count"
    }
}

// MARK: - Member
struct TrackMember: Codable {
    let id: Int?
    let name: String?
    let email: String?
    let roleId: Int?
    let isOwner: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case roleId = "role_id"
        case isOwner = "is_owner"
    }
}
