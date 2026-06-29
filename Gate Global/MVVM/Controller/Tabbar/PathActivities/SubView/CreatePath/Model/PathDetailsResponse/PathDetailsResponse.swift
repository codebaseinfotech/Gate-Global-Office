//
//  PathDetailsResponse.swift
//  Pathrium
//
//  Created by Kenil on 29/06/26.
//

import Foundation

// MARK: - Response
struct PathDetailsResponse: Codable {
    let success: Bool?
    let statusCode: Int?
    let message: String?
    let data: PathDetails?
    let meta: Meta?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data, meta
    }
}

// MARK: - Path
struct PathDetails: Codable {
    let id: Int?
    let name: String?
    let pathType: String?
    let description: String?
    let pathLogo: String?
    let directory: String?
    let companyName: String?
    let contactPersonName: String?
    let mobileNumber: String?
    let countryCode: String?
    let email: String?
    let address: String?
    let currency: String?
    let contract: String?
    let dueDate: String?
    let expiryDate: String?
    let paymentTerms: String?
    let createdBy: Int?
    let settings: PathSettings?
    let colorTagId: Int?
    let createdAt: String?
    let updatedAt: String?
    let creator: PathUser?
    let members: [Member]?
    let membersCount: Int?
    let tracks: [Track]?
    let vault: Vault?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, directory, email, address, currency, contract, settings, creator, members, tracks, vault
        case pathType = "path_type"
        case pathLogo = "path_logo"
        case contactPersonName = "contact_person_name"
        case mobileNumber = "mobile_number"
        case countryCode = "country_code"
        case dueDate = "due_date"
        case expiryDate = "expiry_date"
        case paymentTerms = "payment_terms"
        case createdBy = "created_by"
        case colorTagId = "color_tag_id"
        case companyName = "company_name"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case membersCount = "members_count"
    }
}

// MARK: - User
struct PathUser: Codable {
    let id: Int?
    let name: String?
    let email: String?
}

// MARK: - Member
struct Member: Codable {
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

// MARK: - Track
struct Track: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let order: Int?
    let colorTagId: Int?
    let members: [Member]?
    let membersCount: Int?
    let vault: Vault?
    let destinations: [Destination]?

    enum CodingKeys: String, CodingKey {
        case id, name, description, order, members, vault, destinations
        case colorTagId = "color_tag_id"
        case membersCount = "members_count"
    }
}

// MARK: - Destination
struct Destination: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let order: Int?
    let colorTagId: Int?
    let members: [Member]?
    let membersCount: Int?
    let vault: Vault?

    enum CodingKeys: String, CodingKey {
        case id, name, description, order, members, vault
        case colorTagId = "color_tag_id"
        case membersCount = "members_count"
    }
}

// MARK: - Vault
struct Vault: Codable {
    let folders: [Folder]?
    let attachments: [Attachment]?
}

// MARK: - Folder
struct Folder: Codable {
    let id: Int?
    let name: String?
    let type: String?
    let parentId: Int?
    let colorTagId: Int?
    let createdAt: String?
    let updatedAt: String?
    let colorTag: ColorTag?
    let attachments: [Attachment]?
    let children: [Folder]?

    enum CodingKeys: String, CodingKey {
        case id, name, type, attachments, children
        case parentId = "parent_id"
        case colorTagId = "color_tag_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case colorTag = "color_tag"
    }
}

// MARK: - ColorTag
struct ColorTag: Codable {
    let id: Int?
    let label: String?
    let hexCode: String?

    enum CodingKeys: String, CodingKey {
        case id, label
        case hexCode = "hex_code"
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let id: Int?
    let folderId: Int?
    let fileName: String?
    let filePath: String?
    let mimeType: String?
    let size: Int?
    let colorTagId: Int?
    let documentStatusId: Int?
    let uploadedBy: Int?
    let createdAt: String?
    let updatedAt: String?
    let attachmentType: String?
    let documentName: String?
    let documentReferenceNumber: String?
    let documentDate: String?
    let dueDate: String?
    let expiryDate: String?
    let documentStatus: String?
    let metadata: Metadata?
    let uploadedByUser: PathUser?

    enum CodingKeys: String, CodingKey {
        case id, size, metadata
        case folderId = "folder_id"
        case fileName = "file_name"
        case filePath = "file_path"
        case mimeType = "mime_type"
        case colorTagId = "color_tag_id"
        case documentStatusId = "document_status_id"
        case uploadedBy = "uploaded_by"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case attachmentType = "attachment_type"
        case documentName = "document_name"
        case documentReferenceNumber = "document_reference_number"
        case documentDate = "document_date"
        case dueDate = "due_date"
        case expiryDate = "expiry_date"
        case documentStatus = "document_status"
        case uploadedByUser = "uploaded_by_user"
    }
}

struct PathSettings: Codable {
    let sendMeetingInvitations: Bool?
    let liveChat: Bool?
    let notifications: Bool?

    enum CodingKeys: String, CodingKey {
        case sendMeetingInvitations = "send_meeting_invitations"
        case liveChat = "live_chat"
        case notifications
    }
}

struct Metadata: Codable {
    let type: String?
    let documentName: String?
    let documentReferenceNumber: String?
    let documentDate: String?
    let dueDate: String?
    let expiryDate: String?
    let colorTagId: String?

    enum CodingKeys: String, CodingKey {
        case type
        case documentName = "document_name"
        case documentReferenceNumber = "document_reference_number"
        case documentDate = "document_date"
        case dueDate = "due_date"
        case expiryDate = "expiry_date"
        case colorTagId = "color_tag_id"
    }
}
