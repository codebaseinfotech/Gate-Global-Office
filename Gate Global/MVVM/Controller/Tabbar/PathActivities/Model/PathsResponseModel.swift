//
//  PathsResponseModel.swift
//  Gate Global
//
//  Created by Poojagabani on 04/05/26.
//

import Foundation

import Foundation

// MARK: - Main Response
struct PathsResponseModel: Codable {
    let success: Bool
    let statusCode: Int
    let message: String
    let data: [PathModel]
    let meta: MetaModel?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message
        case data
        case meta
    }
}

// MARK: - Path Model
struct PathModel: Codable {
    let id: Int
    let name: String
    let pathType: String
    let description: String?
    let pathLogo: String?
    let colorTagId: Int?
    let createdBy: Int
    let createdAt: String
    let creator: CreatorModel

    let members: [MemberModel]
    let membersCount: Int

    let attachments: [AttachmentModel]
    let attachmentsCount: Int

    let tracksCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case pathType = "path_type"
        case description
        case pathLogo = "path_logo"
        case colorTagId = "color_tag_id"
        case createdBy = "created_by"
        case createdAt = "created_at"
        case creator
        case members
        case membersCount = "members_count"
        case attachments
        case attachmentsCount = "attachments_count"
        case tracksCount = "tracks_count"
    }
}

// MARK: - Creator
struct CreatorModel: Codable {
    let id: Int
    let name: String
    let email: String
}

// MARK: - Member
struct MemberModel: Codable {
    let id: Int
    let name: String
    let firstName: String
    let lastName: String
    let email: String
    let isOwner: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case isOwner = "is_owner"
    }
}

// MARK: - Attachment
struct AttachmentModel: Codable {
    let id: Int
    let fileName: String
    let filePath: String
    let mimeType: String
    let size: Int

    enum CodingKeys: String, CodingKey {
        case id
        case fileName = "file_name"
        case filePath = "file_path"
        case mimeType = "mime_type"
        case size
    }
}

// MARK: - Meta
struct MetaModel: Codable {
    let requestId: String
    let timestamp: String
    let responseTimeMs: Int

    enum CodingKeys: String, CodingKey {
        case requestId = "request_id"
        case timestamp
        case responseTimeMs = "response_time_ms"
    }
}
