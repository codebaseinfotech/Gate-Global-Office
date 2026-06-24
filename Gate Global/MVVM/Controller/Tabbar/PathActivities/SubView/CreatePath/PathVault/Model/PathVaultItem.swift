//
//  PathVaultItem.swift
//  Gate Global
//
//  Created on 06/05/26.
//

import UIKit

enum PathVaultItemType: String {
    case folder = "Folder"
    case file = "File"
    case image = "Image"
    case pdf = "PDF"
    case document = "Document"
    case trackVault = "Track Vault"
    case destinationVault = "Destination Vault"
    case sectionHeader = "Section"
    case noItems = "Empty"

    var icon: UIImage? {
        switch self {
        case .folder:
            return UIImage(systemName: "folder.fill")
        case .file:
            return UIImage(systemName: "doc.fill")
        case .image:
            return UIImage(systemName: "photo.fill")
        case .pdf:
            return UIImage(systemName: "doc.richtext.fill")
        case .document:
            return UIImage(systemName: "doc.text.fill")
        case .noItems:
            return UIImage(systemName: "folder.fill")
        case .trackVault, .destinationVault, .sectionHeader:
            return nil
        }
    }

    var tintColor: UIColor {
        switch self {
        case .folder:
            return UIColor.systemYellow
        case .file:
            return UIColor.systemBlue
        case .image:
            return UIColor.systemGreen
        case .pdf:
            return UIColor.systemRed
        case .document:
            return UIColor.systemIndigo
        case .noItems:
            return UIColor.systemGray
        case .trackVault, .destinationVault, .sectionHeader:
            return UIColor.clear
        }
    }
}

enum PathVaultFolderColor {
    case yellow
    case green
    case red
    case gray
    case `default`

    var color: UIColor {
        switch self {
        case .yellow:
            return UIColor.systemYellow
        case .green:
            return UIColor.systemGreen
        case .red:
            return UIColor.systemRed
        case .gray:
            return UIColor.systemGray
        case .default:
            return UIColor.systemYellow
        }
    }
}

enum PathVaultStatusColor {
    case yellow
    case green
    case red
    case gray
    case none

    var color: UIColor {
        switch self {
        case .yellow:
            return UIColor.systemYellow
        case .green:
            return UIColor.systemGreen
        case .red:
            return UIColor.systemRed
        case .gray:
            return UIColor.systemGray
        case .none:
            return UIColor.clear
        }
    }
}

class PathVaultItem {
    let id: String
    var name: String
    var type: PathVaultItemType
    var children: [PathVaultItem]
    var isExpanded: Bool
    var level: Int
    weak var parent: PathVaultItem?

    var author: String?
    var statusColor: PathVaultStatusColor
    var folderColor: PathVaultFolderColor
    var isSection: Bool
    var isSectionHeader: Bool

    var hasChildren: Bool {
        return !children.isEmpty
    }

    var typeLabel: String {
        return type.rawValue
    }

    init(id: String = UUID().uuidString,
         name: String,
         type: PathVaultItemType,
         children: [PathVaultItem] = [],
         isExpanded: Bool = false,
         level: Int = 0,
         author: String? = nil,
         statusColor: PathVaultStatusColor = .none,
         folderColor: PathVaultFolderColor = .default,
         isSection: Bool = false,
         isSectionHeader: Bool = false) {
        self.id = id
        self.name = name
        self.type = type
        self.children = children
        self.isExpanded = isExpanded
        self.level = level
        self.author = author
        self.statusColor = statusColor
        self.folderColor = folderColor
        self.isSection = isSection
        self.isSectionHeader = isSectionHeader

        for child in children {
            child.parent = self
            child.level = level + 1
        }
    }

    func addChild(_ child: PathVaultItem) {
        child.parent = self
        child.level = self.level + 1
        children.append(child)
    }

    func flattenedItems() -> [PathVaultItem] {
        var items: [PathVaultItem] = [self]
        if isExpanded {
            for child in children {
                items.append(contentsOf: child.flattenedItems())
            }
        }
        return items
    }
}
