//
//  PathVaultCell.swift
//  Gate Global
//
//  Created on 06/05/26.
//

import UIKit

protocol PathVaultCellDelegate: AnyObject {
    func pathVaultCell(_ cell: PathVaultCell, didToggleExpansionFor item: PathVaultItem)
}

class PathVaultCell: UITableViewCell {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imgChevron: UIImageView!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var viewStatusDot: UIView!
    @IBOutlet weak var lblTypeLabel: UILabel!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var chevronWidthConstraint: NSLayoutConstraint!

    weak var delegate: PathVaultCellDelegate?
    private var item: PathVaultItem?

    private let indentationOffset: CGFloat = 24
    private let baseLeading: CGFloat = 16

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        addTapGesture()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func setupUI() {
        selectionStyle = .none
        imgChevron.image = UIImage(systemName: "chevron.down")
        imgChevron.tintColor = .darkGray
        viewStatusDot.layer.cornerRadius = 4
    }

    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        viewContainer.addGestureRecognizer(tap)
        viewContainer.isUserInteractionEnabled = true
    }

    @objc private func handleTap() {
        guard let item = item, item.hasChildren else { return }
        delegate?.pathVaultCell(self, didToggleExpansionFor: item)
    }

    func configure(with item: PathVaultItem) {
        self.item = item

        // Configure indentation based on level
        leadingConstraint.constant = baseLeading + (CGFloat(item.level) * indentationOffset)

        // Handle section header type
        if item.isSectionHeader {
            configureSectionHeader(item)
            return
        }

        // Handle "No items" type
        if item.type == .noItems {
            configureNoItems(item)
            return
        }

        lblName.text = item.name
        lblName.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        lblName.textColor = .black

        // Configure chevron visibility
        if item.hasChildren {
            imgChevron.isHidden = false
            chevronWidthConstraint.constant = 20
            updateChevronRotation(expanded: item.isExpanded, animated: false)
        } else {
            imgChevron.isHidden = true
            chevronWidthConstraint.constant = 0
        }

        // Configure icon
        if let icon = item.type.icon {
            imgIcon.isHidden = false
            imgIcon.image = icon
            // Use custom folder color if it's a folder
            if item.type == .folder {
                imgIcon.tintColor = item.folderColor.color
            } else {
                imgIcon.tintColor = item.type.tintColor
            }
        } else {
            imgIcon.isHidden = true
        }

        // Configure metadata (right side)
        if let author = item.author {
            lblAuthor.isHidden = false
            lblAuthor.text = "By \(author)"
        } else {
            lblAuthor.isHidden = true
        }

        // Configure type label
        if item.isSection {
            lblTypeLabel.isHidden = false
            lblTypeLabel.text = item.typeLabel
            lblTypeLabel.textColor = .systemGray
        } else if !item.typeLabel.isEmpty {
            lblTypeLabel.isHidden = false
            lblTypeLabel.text = item.typeLabel
            lblTypeLabel.textColor = .darkGray
        } else {
            lblTypeLabel.isHidden = true
        }

        // Configure status dot
        if item.statusColor != .none {
            viewStatusDot.isHidden = false
            viewStatusDot.backgroundColor = item.statusColor.color
        } else {
            viewStatusDot.isHidden = true
        }

        // Configure background for sections
        if item.isSection {
            viewContainer.backgroundColor = UIColor(red: 0.9, green: 0.95, blue: 1.0, alpha: 1.0)
        } else {
            viewContainer.backgroundColor = .white
        }
    }

    private func configureSectionHeader(_ item: PathVaultItem) {
        lblName.text = item.name
        lblName.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        lblName.textColor = .darkGray

        imgChevron.isHidden = true
        chevronWidthConstraint.constant = 0
        imgIcon.isHidden = true
        lblAuthor.isHidden = true
        viewStatusDot.isHidden = true
        lblTypeLabel.isHidden = true
        viewContainer.backgroundColor = .white
    }

    private func configureNoItems(_ item: PathVaultItem) {
        lblName.text = "No items"
        lblName.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lblName.textColor = .systemGray

        imgChevron.isHidden = true
        chevronWidthConstraint.constant = 0
        imgIcon.isHidden = false
        imgIcon.image = UIImage(systemName: "folder.fill")
        imgIcon.tintColor = .systemGray
        lblAuthor.isHidden = true
        viewStatusDot.isHidden = true
        lblTypeLabel.isHidden = true
        viewContainer.backgroundColor = .white
    }

    func updateChevronRotation(expanded: Bool, animated: Bool) {
        let angle: CGFloat = expanded ? 0 : -.pi / 2
        if animated {
            UIView.animate(withDuration: 0.25) {
                self.imgChevron.transform = CGAffineTransform(rotationAngle: angle)
            }
        } else {
            imgChevron.transform = CGAffineTransform(rotationAngle: angle)
        }
    }
}
