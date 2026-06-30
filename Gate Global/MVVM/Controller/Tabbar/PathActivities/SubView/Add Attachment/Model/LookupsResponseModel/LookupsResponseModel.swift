//
//  LookupsResponseModel.swift
//  Pathrium
//
//  Created by Kenil on 30/06/26.
//

import Foundation

// MARK: - Main Response
struct LookupsResponseModel: Codable {
    let success: Bool?
    let statusCode: Int?
    let message: String?
    let data: LookupData?
    let meta: ResponseMeta?

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message
        case data
        case meta
    }
}

// MARK: - Data
struct LookupData: Codable {
    let companies: [LookupItem]?
    let entities: [LookupItem]?
    let attachmentTypes: [LookupItem]?
    let alerts: [AlertItem]?
    let repeats: [RepeatItem]?

    enum CodingKeys: String, CodingKey {
        case companies
        case entities
        case attachmentTypes = "attachment_types"
        case alerts
        case repeats
    }
}

// MARK: - Common Lookup Item
struct LookupItem: Codable {
    let id: Int?
    let name: String?
    let initial: String?
}

// MARK: - Alert
struct AlertItem: Codable {
    let id: String?
    let name: String?
    let minutes: Int?
    let isCustom: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case minutes
        case isCustom = "is_custom"
    }
}

// MARK: - Repeat
struct RepeatItem: Codable {
    let id: String?
    let name: String?
    let type: String?
    let interval: Int?
    let isCustom: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case interval
        case isCustom = "is_custom"
    }
}

// MARK: - Meta
struct ResponseMeta: Codable {
    let requestId: String?
    let timestamp: String?
    let responseTimeMS: Int?

    enum CodingKeys: String, CodingKey {
        case requestId = "request_id"
        case timestamp
        case responseTimeMS = "response_time_ms"
    }
}
