//
//  AddAttachmentVC.swift
//  Gate Global
//
//  Created by Poojagabani on 07/05/26.
//

import UIKit
import UniformTypeIdentifiers

class AddAttachmentVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate {
    
    @IBOutlet weak var txtSelectType: UITextField!
    @IBOutlet weak var txtDocumentName: UITextField!
    @IBOutlet weak var txtReferenceNum: UITextField!
    @IBOutlet weak var txtDocumentDate: UITextField!
    @IBOutlet weak var txtDueDate: UITextField!
    @IBOutlet weak var txtExpiryDate: UITextField!
    @IBOutlet weak var txtDocumentStatus: UITextField!
    @IBOutlet weak var imgDocument: UIImageView!
    @IBOutlet weak var svFileText: UIStackView!
    @IBOutlet weak var collectionViewColorTag: UICollectionView! {
        didSet {
            collectionViewColorTag.register(UINib(nibName: "CreateFolderColorsCVCell", bundle: nil), forCellWithReuseIdentifier: "CreateFolderColorsCVCell")
            collectionViewColorTag.delegate = self
            collectionViewColorTag.dataSource = self
        }
    }
    @IBOutlet weak var lblColorTagPriority: UILabel!
    
    var arrColors: [UIColor] = [.red, .orange, .yellow, .green, .blue, .purple, .gray]
    var selectedIndex = -1
    
    var arrFolderPriority = ["High Priority", "Medium Priority", "Low Priority", "Live", "Informational", "Confidential", "Archive"]
    
    var arrTypes = [
        "PDF",
        "Image",
        "Document",
        "Excel",
        "Video"
    ]
    var arrStatus = [
        "Pending",
        "Approved",
        "Rejected",
        "Completed"
    ]
    
    var typeDropDown = DropDown()
    var statusDropDown = DropDown()
    
    let documentDatePicker = UIDatePicker()
    let dueDatePicker = UIDatePicker()
    let expiryDatePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDropDowns()
                setupDatePickers()
        // Do any additional setup after loading the view.
    }
    
    func setupDropDowns() {
        
        // Type Dropdown
        typeDropDown.dataSource = arrTypes
        typeDropDown.direction = .bottom
        typeDropDown.anchorView = txtSelectType
        
        typeDropDown.selectionAction = { [weak self] index, item in
            self?.txtSelectType.text = item
        }
        
        // Status Dropdown
        statusDropDown.dataSource = arrStatus
        statusDropDown.direction = .bottom
        statusDropDown.anchorView = txtDocumentStatus
        
        statusDropDown.selectionAction = { [weak self] index, item in
            self?.txtDocumentStatus.text = item
        }
    }
    
    func setupDatePickers() {
        
        setupDatePicker(documentDatePicker, textField: txtDocumentDate)
        setupDatePicker(dueDatePicker, textField: txtDueDate)
        setupDatePicker(expiryDatePicker, textField: txtExpiryDate)
    }
    
    func setupDatePicker(_ picker: UIDatePicker, textField: UITextField) {
        
        picker.datePickerMode = .date
        
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        }
        
        textField.inputView = picker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(doneDateTapped)
        )
        
        toolbar.setItems([doneBtn], animated: true)
        textField.inputAccessoryView = toolbar
    }
    
    @objc func doneDateTapped() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        if txtDocumentDate.isFirstResponder {
            txtDocumentDate.text = formatter.string(from: documentDatePicker.date)
        }
        
        if txtDueDate.isFirstResponder {
            txtDueDate.text = formatter.string(from: dueDatePicker.date)
        }
        
        if txtExpiryDate.isFirstResponder {
            txtExpiryDate.text = formatter.string(from: expiryDatePicker.date)
        }
        
        view.endEditing(true)
    }
    
    @IBAction func tappedBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }
    
    @IBAction func tappedType(_ sender: Any) {
        typeDropDown.show()
    }
    
    @IBAction func tappedDocumentDate(_ sender: Any) {
        txtDocumentDate.becomeFirstResponder()
    }
    
    @IBAction func tappedDueDate(_ sender: Any) {
        txtDueDate.becomeFirstResponder()
    }
    
    @IBAction func tappedExpiryDate(_ sender: Any) {
        txtExpiryDate.becomeFirstResponder()
    }
    
    @IBAction func tappedDocumentStatus(_ sender: Any) {
        statusDropDown.show()
    }
    
    @available(iOS 14.0, *)
    @IBAction func tappedUploadFile(_ sender: Any) {
        let documentPicker = UIDocumentPickerViewController(
            forOpeningContentTypes: [
                .pdf,
                .image,
                .spreadsheet,
                .text,
                .data
            ],
            asCopy: true
        )
        
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        
        present(documentPicker, animated: true)
    }
    
    @IBAction func tappedAddAttachment(_ sender: Any) {
    }
    

}

extension AddAttachmentVC {
    
    func openCamera() {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            
            present(picker, animated: true)
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
            imgDocument.image = image
        } else if let image = info[.originalImage] as? UIImage {
            imgDocument.image = image
        }
        
        svFileText.isHidden = true
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController,
                        didPickDocumentsAt urls: [URL]) {
        
        guard let fileURL = urls.first else { return }
        
        // File name show
        txtDocumentName.text = fileURL.lastPathComponent
        
        // Hide upload text
        svFileText.isHidden = true
        
        // Optional image preview
        if let image = UIImage(contentsOfFile: fileURL.path) {
            imgDocument.image = image
        }
        
        print("Selected File:", fileURL)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Document Picker Cancelled")
    }
}

extension AddAttachmentVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionViewColorTag.dequeueReusableCell(withReuseIdentifier: "CreateFolderColorsCVCell", for: indexPath) as! CreateFolderColorsCVCell
        
        cell.viewColor.backgroundColor = arrColors[indexPath.row]
        cell.imgSelectedColor.isHidden = selectedIndex != indexPath.row
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row
        lblColorTagPriority.text = arrFolderPriority[indexPath.row]
        lblColorTagPriority.isHidden = false
        collectionView.reloadData()
    }
    
}

extension AddAttachmentVC: UICollectionViewDelegateFlowLayout {
    // MARK: - Section Insets
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7)
    }
    // MARK: - Minimum Line Spacing (Vertical)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    // MARK: - Minimum Interitem Spacing (Horizontal)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 25, height: 25)
    }
    
}
