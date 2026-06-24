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
    
    var dropDown = DropDown()
    
    var pathTypes = ["Internal", "External"]
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        viewPathNamePopUp.isHidden = true
        svMainTrackName.isHidden = true
        svMainDestination.isHidden = true
        
        setupPathTypeDropDown()
        setupPopups()
        // Do any additional setup after loading the view.
    }

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
    
    @IBAction func tappedAddDestination(_ sender: Any) {
        let vc = AddNewPathPopUpVC()
        vc.modalPresentationStyle = .overFullScreen
        vc.actionType = .addNewDestination
        
        vc.onSubmit = { [weak self] value in
            guard let self = self else { return }
            
            self.svMainDestination.isHidden = false
            
            self.viewAddDestinationBtn.isHidden = true
            
            self.txtDestination.text = value
            
            var list = self.viewDestinationPopUp.destination
            list.removeAll(where: { $0 == value })
            list.insert(value, at: 1)
            self.viewDestinationPopUp.destination = list
            
            self.viewDestinationPopUp.tblViewPathList.reloadData()
        }
        
        self.present(vc, animated: false)
    }
    
    @IBAction func tappedDestination(_ sender: Any) {
        showPopup(viewDestinationPopUp)
    }
    
    @IBAction func tappedAddAttachment(_ sender: Any) {
        self.setUpMakeToast(msg: "Add Attachment not implemented yet")
    }
    
    @IBAction func tappedCreateFolder(_ sender: Any) {
        self.setUpMakeToast(msg: "Create Folder not implemented yet")
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
                    self.txtPathName.text = value
                    
                    self.viewPathNamePopUp.pathName.insert(value, at: 0)
                    self.viewPathNamePopUp.tblViewPathList.reloadData()
                    
                    self.svMainTrackName.isHidden = false
                    self.txtTrackName.text = self.viewTrackNamePopUp.defaultOption
                    
                    self.svMainDestination.isHidden = true
                    self.txtDestination.text = ""

                case .addNewTrack:
                    self.txtTrackName.text = value
                    
                    self.viewTrackNamePopUp.trackName.insert(value, at: 0)
                    self.viewTrackNamePopUp.tblViewPathList.reloadData()
                    
                    self.svMainDestination.isHidden = false
                    self.viewAddDestinationBtn.isHidden = true
                    self.txtDestination.text = self.viewDestinationPopUp.defaultOption

                case .addNewDestination:
                    self.txtDestination.text = value
                    
                    self.viewDestinationPopUp.destination.insert(value, at: 1)
                    self.viewDestinationPopUp.tblViewPathList.reloadData()
                }
            }

            self.present(vc, animated: false)
        }
        
        popup.onSelect = { [weak self] value in
            guard let self = self else { return }
            
            switch type {
            case .addNewPath:
                self.txtPathName.text = value
                
                self.svMainTrackName.isHidden = false
                
                self.txtTrackName.text = self.viewTrackNamePopUp.defaultOption
                
                self.svMainDestination.isHidden = true
                self.txtDestination.text = ""
                
            case .addNewTrack:
                self.txtTrackName.text = value
                
                self.svMainDestination.isHidden = false
                self.viewAddDestinationBtn.isHidden = true
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
    
}
