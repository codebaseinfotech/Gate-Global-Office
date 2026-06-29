//
//  MasterDataResponse.swift
//  Pathrium
//
//  Created by Kenil on 29/06/26.
//

import Foundation

// MARK: - Root Response
struct MasterDataResponse: Codable {
    let success: Bool?
    let data: MasterData?
}

// MARK: - Data
struct MasterData: Codable {
    let colorTags: [MasterColorTag]?
    let statuses: [MasterStatus]?
    let vaultTypes: [VaultType]?
    let accessLevels: [AccessLevel]?

    enum CodingKeys: String, CodingKey {
        case colorTags = "color_tags"
        case statuses
        case vaultTypes = "vault_types"
        case accessLevels = "access_levels"
    }
}

// MARK: - Color Tag
struct MasterColorTag: Codable {
    let id: Int?
    let key: String?
    let label: String?
    let hexCode: String?
    let emoji: String?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case id
        case key
        case label
        case hexCode = "hex_code"
        case emoji
        case description
    }
}

// MARK: - Status
struct MasterStatus: Codable {
    let id: Int?
    let key: String?
    let label: String?
    let group: String?
    let description: String?
    let color: String?
}

// MARK: - Vault Type
struct VaultType: Codable {
    let id: Int?
    let name: String?
}

// MARK: - Access Level
struct AccessLevel: Codable {
    let key: String?
    let label: String?
}
