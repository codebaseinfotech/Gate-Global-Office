//
//  PathsResponseModel.swift
//  Gate Global
//
//  Created by Poojagabani on 04/05/26.
//

import Foundation

// MARK: - Main Response
struct PathsResponseModel: Codable {
    let success: Bool
    let statusCode: Int
    let message: String
    let data: [PathModel]
    let meta: Meta?

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
    let membersCount: Int
    let tracksCount: Int

    enum CodingKeys: String, CodingKey {
        case id, name, description, creator
        case pathType = "path_type"
        case pathLogo = "path_logo"
        case colorTagId = "color_tag_id"
        case createdBy = "created_by"
        case createdAt = "created_at"
        case membersCount = "members_count"
        case tracksCount = "tracks_count"
    }
}

// MARK: - Creator
struct CreatorModel: Codable {
    let id: Int
    let name: String
    let email: String
}
