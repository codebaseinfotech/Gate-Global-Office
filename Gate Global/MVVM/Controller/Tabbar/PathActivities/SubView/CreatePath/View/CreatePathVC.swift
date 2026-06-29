//
//  CreatePathVC.swift
//  Gate Global
//
//  Created by Poojagabani on 04/05/26.
//

enum ActiveField {
    case pathType, trackName, destination
}

import UIKit

class CreatePathVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtPathName: UITextField!
    @IBOutlet weak var txtPathType: UITextField!
    @IBOutlet weak var txtViewDes: UITextView!
    @IBOutlet weak var txtContactPersonName: UITextField!
    @IBOutlet weak var txtPhoneNum: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var switchLiveChat: UISwitch!
    @IBOutlet weak var svSelectPhotoText: UIStackView!
    @IBOutlet weak var imgPathPhoto: UIImageView!
    @IBOutlet weak var viewPathNamePopUp: PathNameListView!
    @IBOutlet weak var viewSelectPathType: UIView!
    @IBOutlet weak var txtTrackName: UITextField!
    @IBOutlet weak var btnAddDestination: UIButton!
    @IBOutlet weak var svMainTrackName: UIStackView!
    @IBOutlet weak var svMainDestination: UIStackView!
    @IBOutlet weak var txtDestination: UITextField!
    @IBOutlet weak var viewTrackNamePopUp: PathNameListView!
    @IBOutlet weak var viewDestinationPopUp: PathNameListView!
    @IBOutlet weak var viewAddDestinationBtn: UIView!
    @IBOutlet weak var tblPathVault: UITableView!
    @IBOutlet weak var collectionViewMembersList: UICollectionView! {
        didSet {
            collectionViewMembersList.register(UINib(nibName: "MembersListCVCell", bundle: nil), forCellWithReuseIdentifier: "MembersListCVCell")
            collectionViewMembersList.delegate = self
            collectionViewMembersList.dataSource = self
        }
    }
    @IBOutlet weak var heightConstMemberListCV: NSLayoutConstraint!
    @IBOutlet weak var viewAddTrackBtn: UIView! {
        didSet {
            viewAddTrackBtn.isHidden = true
        }
    }
    
    var dropDown = DropDown()

    var pathTypes = ["Internal", "External"]

    var vaultRootItems: [PathVaultItem] = []
    private var vaultDisplayItems: [PathVaultItem] = []

    var createPathVM = CreatePathVM()
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        viewPathNamePopUp.isHidden = true
        svMainTrackName.isHidden = true
        svMainDestination.isHidden = true

        setupPathTypeDropDown()
        setupPopups()
        setupPathVault()
        setUpUser()
    }
    
    // MARK: - setUpAPI
    func setUpUser() {
        
        createPathVM.getPathList()
        
        // Success Response
        createPathVM.successPathList = {
            self.viewPathNamePopUp.pathName = self.createPathVM.pathList
        }
        createPathVM.failurePathList = { msg in
            self.setUpMakeToast(msg: msg)
        }
        
        createPathVM.successPathDetails = {
            self.txtPathName.text = self.createPathVM.pathDetails?.name
            
            self.svMainTrackName.isHidden = (self.createPathVM.pathDetails?.tracks?.count ?? 0) > 0 ? false : true
            self.viewAddTrackBtn.isHidden = (self.createPathVM.pathDetails?.tracks?.count ?? 0) > 0 ? true : false
            
            let allData = Track(
                id: 0,
                name: "All",
                description: "",
                order: 0,
                colorTagId: 0,
                members: [],
                membersCount: 0,
                vault: nil,
                destinations: []
            )

            self.viewTrackNamePopUp.trackName = [allData] + (self.createPathVM.pathDetails?.tracks ?? [])
            
            let allDestinations = Destination(
                id: 0,
                name: "All",
                description: "",
                order: 0,
                colorTagId: 0,
                members: [],
                membersCount: 0,
                vault: nil
            )

            let trackDetails = self.createPathVM.pathDetails?.tracks?.first(where: { $0.id == self.createPathVM.track_id })
            
            self.viewDestinationPopUp.destination = [allDestinations] + (trackDetails?.destinations ?? [])

            self.svMainDestination.isHidden = (trackDetails?.destinations?.count ?? 0) > 0 ? false : true
            self.viewAddDestinationBtn.isHidden = (trackDetails?.destinations?.count ?? 0) > 0 ? true : false
            
            self.collectionViewMembersList.reloadData()
        }
        createPathVM.failurePathDetails = { msg in
            self.setUpMakeToast(msg: msg)
        }
        
        createPathVM.successCreateTrack = {
            self.txtTrackName.text = self.createPathVM.trackDetails?.name ?? ""
            self.createPathVM.track_id = self.createPathVM.trackDetails?.id ?? 0
            
            self.createPathVM.getPathDetails()
            
        }
        createPathVM.failureCreateTrack = { msg in
            self.setUpMakeToast(msg: msg)
        }
        
        createPathVM.successCreatePath = {
            self.createPathVM.getPathList()
            self.createPathVM.getPathDetails()
            
        }
        createPathVM.failureCreatePath = { msg in
            self.setUpMakeToast(msg: msg)
        }
        
        createPathVM.successCreateDestinations = {
            self.createPathVM.getPathDetails()
        }
        createPathVM.failureCreateDestinations = { msg in
            self.setUpMakeToast(msg: msg)
        }
    }
    
    // MARK: - Action Method
    @IBAction func tappedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedPathName(_ sender: Any) {
        showPopup(viewPathNamePopUp)
    }
    
    @IBAction func tappedPathType(_ sender: Any) {
        dropDown.anchorView = txtPathType
        dropDown.show()
    }
    
    @IBAction func tappedPathLogo(_ sender: Any) {
        let alert = UIAlertController(title: "Select Path Logo", message: nil, preferredStyle: .actionSheet)
        
        // Camera
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        // Gallery
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        // Cancel
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(alert, animated: true)
    }
    
    @IBAction func tappedTrackName(_ sender: Any) {
        showPopup(viewTrackNamePopUp)
    }
    @IBAction func tappedAddTrackName(_ sender: Any) {
        let vc = AddNewPathPopUpVC()
        vc.modalPresentationStyle = .overFullScreen

        // ✅ SET TYPE PROPERTY INSTEAD
        vc.actionType = .addNewTrack

        vc.onSubmit = { value in
            self.createPathVM.createTrackName(name: value)
    
        }

        self.present(vc, animated: false)
    }
    
    @IBAction func tappedAddDestination(_ sender: Any) {
        let vc = AddNewPathPopUpVC()
        vc.modalPresentationStyle = .overFullScreen
        vc.actionType = .addNewDestination
        
        vc.onSubmit = { [weak self] value in
            guard let self = self else { return }
            self.createPathVM.createDestinations(name: value)
        }
        
        self.present(vc, animated: false)
    }
    
    @IBAction func tappedDestination(_ sender: Any) {
        showPopup(viewDestinationPopUp)
    }
    
    @IBAction func tappedAddAttachment(_ sender: Any) {
        guard let pathName = txtPathName.text,
              !pathName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            setUpMakeToast(msg: "Please select path name")
            return
        }
        
        let vc = AddAttachmentVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tappedCreateFolder(_ sender: Any) {
        guard let pathName = txtPathName.text,
              !pathName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            setUpMakeToast(msg: "Please select path name")
            return
        }
        
        let vc = CreateFolderPopUpVC()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
    
    
    func showPopup(_ popup: UIView?) {
        guard let popup = popup else { return }

        let isSamePopupVisible = !popup.isHidden

        viewPathNamePopUp?.isHidden = true
        viewTrackNamePopUp?.isHidden = true
        viewDestinationPopUp?.isHidden = true

        if isSamePopupVisible { return }

        popup.alpha = 0
        popup.isHidden = false

        UIView.animate(withDuration: 0.25) {
            popup.alpha = 1
        }
    }
    
    func setupPopups() {
        
        if let popup = viewPathNamePopUp {
            popup.isHidden = true
            setupPopup(popup, type: .addNewPath)
        }
        
        if let popup = viewTrackNamePopUp {
            popup.isHidden = true
            setupPopup(popup, type: .addNewTrack)
        }
        
        if let popup = viewDestinationPopUp {
            popup.isHidden = true
            setupPopup(popup, type: .addNewDestination)
        }
    }
    
    func setupPathTypeDropDown() {
        dropDown.dataSource = pathTypes
        dropDown.direction = .bottom
        dropDown.backgroundColor = .white

        if let first = pathTypes.first {
            txtPathType.text = first
        }

        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.txtPathType.text = item
        }
    }
    
    func setupPopup(_ popup: PathNameListView?, type: PathAction) {

        guard let popup = popup else { return }

        popup.type = type

        popup.onAction = { [weak self] action in
            guard let self = self else { return }

            popup.isHidden = true

            let vc = AddNewPathPopUpVC()
            vc.modalPresentationStyle = .overFullScreen

            // ✅ SET TYPE PROPERTY INSTEAD
            vc.actionType = action

            vc.onSubmit = { value in
                switch action {
                case .addNewPath:
                    self.createPathVM.createPathName(name: value)
                    

                case .addNewTrack:
                    self.createPathVM.createTrackName(name: value)

                case .addNewDestination:
                    self.createPathVM.createDestinations(name: value)
                    
                }
            }

            self.present(vc, animated: false)
        }
        
        popup.onSelect = { [weak self] value, id in
            guard let self = self else { return }
            
            switch type {
            case .addNewPath:
                createPathVM.pathId = id
                createPathVM.getPathDetails()
                
            case .addNewTrack:
                
                let trackDetails = createPathVM.pathDetails?.tracks?.first(where: { $0.id == id })

                self.txtTrackName.text = trackDetails?.name
                self.createPathVM.track_id = trackDetails?.id ?? 0
                
                createPathVM.getPathDetails()

                self.txtDestination.text = self.viewDestinationPopUp.defaultOption
                
            case .addNewDestination:
                self.txtDestination.text = value
            }
            
            popup.isHidden = true
        }
        
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            present(picker, animated: true)
        } else {
            print("Camera not available")
        }
    }
    
    func openGallery() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[.editedImage] as? UIImage {
            imgPathPhoto.image = image
        } else if let image = info[.originalImage] as? UIImage {
            imgPathPhoto.image = image
        }
        
        svSelectPhotoText.isHidden = true

        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    // MARK: - Path Vault Setup

    func setupPathVault() {
        tblPathVault?.register(UINib(nibName: "PathVaultCell", bundle: nil), forCellReuseIdentifier: "PathVaultCell")
        tblPathVault?.dataSource = self
        tblPathVault?.delegate = self
        tblPathVault?.separatorStyle = .none

        loadSampleVaultData()
    }

    func loadSampleVaultData() {
        // Master Audio folder (yellow)
        let masterAudio = PathVaultItem(
            name: "Master Audio",
            type: .folder,
            author: "Super",
            statusColor: .yellow,
            folderColor: .yellow
        )

        // TRACK VAULT section header
        let trackVaultHeader = PathVaultItem(
            name: "TRACK VAULT",
            type: .sectionHeader,
            isSectionHeader: true
        )

        // Design Phase (expandable Track Vault section)
        let designPhase = PathVaultItem(
            name: "Design Phase",
            type: .trackVault,
            children: [
                // UI Root folder (red)
                PathVaultItem(
                    name: "UI Root",
                    type: .folder,
                    statusColor: .red,
                    folderColor: .red
                ),
                // Destination Vault section header
                PathVaultItem(
                    name: "Destination Vault",
                    type: .sectionHeader,
                    isSectionHeader: true
                ),
                // UI Design (expandable Destination Vault section)
                PathVaultItem(
                    name: "UI Design",
                    type: .destinationVault,
                    children: [
                        // Dest WEB folder (green)
                        PathVaultItem(
                            name: "Dest WEB",
                            type: .folder,
                            children: [
                                PathVaultItem(
                                    name: "Dest EXC",
                                    type: .document,
                                    author: "Super",
                                    statusColor: .red
                                )
                            ],
                            author: "Super",
                            statusColor: .green,
                            folderColor: .green
                        )
                    ],
                    isSection: true
                ),
                // UX Design (expandable Destination Vault section - empty)
                PathVaultItem(
                    name: "UX Design",
                    type: .destinationVault,
                    children: [
                        PathVaultItem(name: "", type: .noItems)
                    ],
                    isSection: true
                )
            ],
            isSection: true
        )

        // Design Track (expandable Track Vault section - empty)
        let designTrack = PathVaultItem(
            name: "Design Track",
            type: .trackVault,
            children: [
                PathVaultItem(name: "", type: .noItems)
            ],
            isSection: true
        )

        vaultRootItems = [masterAudio, trackVaultHeader, designPhase, designTrack]
        reloadVaultData()
    }

    func reloadVaultData() {
        vaultDisplayItems = vaultRootItems.flatMap { $0.flattenedItems() }
        tblPathVault?.reloadData()
    }

    func addVaultItem(_ item: PathVaultItem, to parent: PathVaultItem? = nil) {
        if let parent = parent {
            parent.addChild(item)
        } else {
            vaultRootItems.append(item)
        }
        reloadVaultData()
    }
}

// MARK: - Path Vault TableView DataSource & Delegate

extension CreatePathVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblPathVault {
            return vaultDisplayItems.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblPathVault {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PathVaultCell", for: indexPath) as! PathVaultCell
            let item = vaultDisplayItems[indexPath.row]
            cell.configure(with: item)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tblPathVault {
            return 50
        }
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblPathVault {
            let item = vaultDisplayItems[indexPath.row]
            if !item.hasChildren {
                setUpMakeToast(msg: "Selected: \(item.name)")
            }
        }
    }
}

// MARK: - PathVaultCellDelegate

extension CreatePathVC: PathVaultCellDelegate {

    func pathVaultCell(_ cell: PathVaultCell, didToggleExpansionFor item: PathVaultItem) {
        guard let indexPath = tblPathVault?.indexPath(for: cell) else { return }

        item.isExpanded.toggle()

        if item.isExpanded {
            let newItems = item.children.flatMap { $0.flattenedItems() }
            let insertIndex = indexPath.row + 1
            vaultDisplayItems.insert(contentsOf: newItems, at: insertIndex)

            let indexPaths = (0..<newItems.count).map {
                IndexPath(row: insertIndex + $0, section: 0)
            }
            tblPathVault?.insertRows(at: indexPaths, with: .fade)
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
            vaultDisplayItems.removeSubrange(removeStart..<(removeStart + removeCount))

            let indexPaths = (0..<removeCount).map {
                IndexPath(row: removeStart + $0, section: 0)
            }
            tblPathVault?.deleteRows(at: indexPaths, with: .fade)
        }

        cell.updateChevronRotation(expanded: item.isExpanded, animated: true)
    }
}

extension CreatePathVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.createPathVM.pathDetails?.members?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MembersListCVCell", for: indexPath) as! MembersListCVCell

        if indexPath.section == 0 {

            cell.viewMainAdd.isHidden = false
            cell.viewMainMembers.isHidden = true

        } else {

            let member = self.createPathVM.pathDetails?.members?[indexPath.row]

            cell.lblMemberFirstLetter.text = member?.name.map { String($0.prefix(2)) } ?? ""
            cell.lblMemberName.text = member?.name

            cell.viewMainAdd.isHidden = true
            cell.viewMainMembers.isHidden = false
        }

        return cell
    }
    
    
}

extension CreatePathVC: UICollectionViewDelegateFlowLayout {
    // MARK: - Section Insets
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5)
    }
    // MARK: - Minimum Line Spacing (Vertical)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // MARK: - Minimum Interitem Spacing (Horizontal)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 60, height: 90)
    }
    
}

