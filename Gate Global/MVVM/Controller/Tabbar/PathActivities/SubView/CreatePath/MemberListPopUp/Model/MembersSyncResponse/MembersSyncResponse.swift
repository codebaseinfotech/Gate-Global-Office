//
//  MembersSyncResponse.swift
//  Pathrium
//
//  Created by Kenil on 29/06/26.
//

import Foundation

// MARK: - Main Response
struct MembersSyncResponse: Codable {
    let success: Bool
    let statusCode: Int
    let message: String
    let data: MembersSyncData
    let meta: Meta

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message
        case data
        case meta
    }
}

// MARK: - Data
struct MembersSyncData: Codable {
    let addedMembers: [AddMember]
    let removedMembers: [AddMember]
    let keptMembers: [AddMember]
    let skippedMembers: [AddMember]
    let shareableType: String
    let shareableId: Int

    enum CodingKeys: String, CodingKey {
        case addedMembers = "added_members"
        case removedMembers = "removed_members"
        case keptMembers = "kept_members"
        case skippedMembers = "skipped_members"
        case shareableType = "shareable_type"
        case shareableId = "shareable_id"
    }
}

// MARK: - Member
struct AddMember: Codable {
    let userId: Int
    let name: String
    let email: String?
    let shareId: Int?

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name
        case email
        case shareId = "share_id"
    }
}
