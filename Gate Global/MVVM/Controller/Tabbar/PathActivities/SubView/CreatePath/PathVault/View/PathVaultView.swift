//
//  PathVaultView.swift
//  Gate Global
//
//  Created on 06/05/26.
//

import UIKit

protocol PathVaultViewDelegate: AnyObject {
    func pathVaultView(_ view: PathVaultView, didSelectItem item: PathVaultItem)
    func pathVaultViewDidTapAddAttachment(_ view: PathVaultView)
    func pathVaultViewDidTapCreateFolder(_ view: PathVaultView)
}

class PathVaultView: UIView {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnAddAttachment: UIButton!
    @IBOutlet weak var btnCreateFolder: UIButton!
    @IBOutlet weak var tblVault: UITableView! {
        didSet {
            tblVault.register(UINib(nibName: "PathVaultCell", bundle: nil), forCellReuseIdentifier: "PathVaultCell")
            tblVault.dataSource = self
            tblVault.delegate = self
            tblVault.separatorStyle = .none
        }
    }
    @IBOutlet weak var viewEmptyState: UIView!
    @IBOutlet weak var lblEmptyMessage: UILabel!

    private let nibName = String(describing: PathVaultView.self)

    weak var delegate: PathVaultViewDelegate?

    var rootItems: [PathVaultItem] = [] {
        didSet {
            reloadData()
        }
    }

    private var displayItems: [PathVaultItem] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }

    private func configureView() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        updateEmptyState()
    }

    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    func reloadData() {
        displayItems = rootItems.flatMap { $0.flattenedItems() }
        tblVault?.reloadData()
        updateEmptyState()
    }

    private func updateEmptyState() {
        let isEmpty = displayItems.isEmpty
        viewEmptyState?.isHidden = !isEmpty
        tblVault?.isHidden = isEmpty
    }

    @IBAction func tappedAddAttachment(_ sender: Any) {
        delegate?.pathVaultViewDidTapAddAttachment(self)
    }

    @IBAction func tappedCreateFolder(_ sender: Any) {
        delegate?.pathVaultViewDidTapCreateFolder(self)
    }

    func addItem(_ item: PathVaultItem, to parent: PathVaultItem? = nil) {
        if let parent = parent {
            parent.addChild(item)
        } else {
            rootItems.append(item)
        }
        reloadData()
    }

    func loadSampleData() {
        let documents = PathVaultItem(
            name: "Documents",
            type: .folder,
            children: [
                PathVaultItem(name: "Project Proposal.pdf", type: .pdf),
                PathVaultItem(name: "Meeting Notes.doc", type: .document),
                PathVaultItem(
                    name: "Reports",
                    type: .folder,
                    children: [
                        PathVaultItem(name: "Q1 Report.pdf", type: .pdf),
                        PathVaultItem(name: "Q2 Report.pdf", type: .pdf)
                    ]
                )
            ]
        )

        let images = PathVaultItem(
            name: "Images",
            type: .folder,
            children: [
                PathVaultItem(name: "Logo.png", type: .image),
                PathVaultItem(name: "Banner.jpg", type: .image)
            ]
        )

        let readme = PathVaultItem(name: "README.txt", type: .file)

        rootItems = [documents, images, readme]
    }
}

extension PathVaultView: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PathVaultCell", for: indexPath) as! PathVaultCell
        let item = displayItems[indexPath.row]
        cell.configure(with: item)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = displayItems[indexPath.row]
        if !item.hasChildren {
            delegate?.pathVaultView(self, didSelectItem: item)
        }
    }
}

extension PathVaultView: PathVaultCellDelegate {

    func pathVaultCell(_ cell: PathVaultCell, didToggleExpansionFor item: PathVaultItem) {
        guard let indexPath = tblVault.indexPath(for: cell) else { return }

        item.isExpanded.toggle()

        if item.isExpanded {
            let newItems = item.children.flatMap { $0.flattenedItems() }
            let insertIndex = indexPath.row + 1
            displayItems.insert(contentsOf: newItems, at: insertIndex)

            let indexPaths = (0..<newItems.count).map {
                IndexPath(row: insertIndex + $0, section: 0)
            }
            tblVault.insertRows(at: indexPaths, with: .fade)
        } else {
            var removeCount = 0
            func countDescendants(_ parent: PathVaultItem) {
                for child in parent.children {
                    removeCount += 1
                    if child.isExpanded {
                        countDescendants(child)
                    }
                    child.isExpanded = false
                }
            }
            countDescendants(item)

            let removeStart = indexPath.row + 1
            displayItems.removeSubrange(removeStart..<(removeStart + removeCount))

            let indexPaths = (0..<removeCount).map {
                IndexPath(row: removeStart + $0, section: 0)
            }
            tblVault.deleteRows(at: indexPaths, with: .fade)
        }

        cell.updateChevronRotation(expanded: item.isExpanded, animated: true)
    }
}
