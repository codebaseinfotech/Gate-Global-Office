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
    @IBOutlet weak var lblUploadDocument: UILabel!
    
    @IBOutlet weak var txtCompany: UITextField!
    @IBOutlet weak var txtEntity: UITextField!
    
    
    var selectedIndex = 0
    
    var typeDropDown = DropDown()
    var statusDropDown = DropDown()
    var companyDropDown = DropDown()
    var entityDropDown = DropDown()
    
    let documentDatePicker = UIDatePicker()
    let dueDatePicker = UIDatePicker()
    let expiryDatePicker = UIDatePicker()
    
    var addAddtachmentVM = AddAttachmentVM()
    var isUploadDocument: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAddtachmentVM.getGeneralList()
        addAddtachmentVM.getLockUp()
        
        addAddtachmentVM.successGenreal = {
            
            self.collectionViewColorTag.reloadData()
            DispatchQueue.main.async {
                self.setupDropDowns()
            }
            
        }
        addAddtachmentVM.failureGenreal = { (error) in
            self.setUpMakeToast(msg: error)
        }
        
        addAddtachmentVM.successLookUps = {
            
            DispatchQueue.main.async {
                self.setupDropDowns()
            }
            
        }
        addAddtachmentVM.failureLookUps = { (error) in
            self.setUpMakeToast(msg: error)
        }
        

        setupDatePickers()
        // Do any additional setup after loading the view.
    }
    
    func setupDropDowns() {
        
        // Type Dropdown
        
        var type: [String] = []
        
        for obj in addAddtachmentVM.valueList {
            type.append(obj.name ?? "")
        }
        
        typeDropDown.dataSource = type
        typeDropDown.direction = .bottom
        typeDropDown.anchorView = txtSelectType
        
        typeDropDown.selectionAction = { [weak self] index, item in
            self?.txtSelectType.text = item
        }
        
        // Status Dropdown
        
        var status: [String] = []
        
        for obj in addAddtachmentVM.statusList {
            status.append(obj.label ?? "")
        }

        statusDropDown.dataSource = status
        statusDropDown.direction = .bottom
        statusDropDown.anchorView = txtDocumentStatus
        
        statusDropDown.selectionAction = { [weak self] index, item in
            self?.txtDocumentStatus.text = item
        }
        
        var companyList: [String] = []
        
        for obj in addAddtachmentVM.companyList {
            companyList.append(obj.name ?? "")
        }
        
        companyDropDown.dataSource = companyList
        companyDropDown.direction = .bottom
        companyDropDown.anchorView = txtCompany
        
        companyDropDown.selectionAction = { [weak self] index, item in
            self?.txtCompany.text = item
        }
        
        var entityList: [String] = []
        
        for obj in addAddtachmentVM.entityList {
            entityList.append(obj.name ?? "")
        }
        
        entityDropDown.dataSource = entityList
        entityDropDown.direction = .bottom
        entityDropDown.anchorView = txtEntity
        
        entityDropDown.selectionAction = { [weak self] index, item in
            self?.txtEntity.text = item
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
    
    @IBAction func tappedComany(_ sender: Any) {
        companyDropDown.show()
    }
    @IBAction func tappedEntity(_ sender: Any) {
        entityDropDown.show()
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
        guard let type = txtSelectType.text, !type.isEmpty else {
            self.setUpMakeToast(msg: "Please select type")
            return
        }
        
        /*guard let name = txtDocumentName.text, !name.isEmpty else {
            self.setUpMakeToast(msg: "Please enter document name")
            return
        }*/
      
        guard let documentDate = txtDocumentDate.text, !documentDate.isEmpty else {
            self.setUpMakeToast(msg: "Please select document date")
            return
        }
        
        
        guard let referenceNumber = txtReferenceNum.text, !referenceNumber.isEmpty else {
            self.setUpMakeToast(msg: "Please enter id")
            return
        }
        
        
        guard let dueDate = txtDueDate.text, !dueDate.isEmpty else {
            self.setUpMakeToast(msg: "Please select due date")
            return
        }
        
        guard let expiryDate = txtExpiryDate.text, !expiryDate.isEmpty else {
            self.setUpMakeToast(msg: "Please select expiry date")
            return
        }
        
        guard let status = txtDocumentStatus.text, !status.isEmpty else {
            self.setUpMakeToast(msg: "Please select document status")
            return
        }
        
        guard isUploadDocument else {
            self.setUpMakeToast(msg: "Please upload file")
            return
        }
        
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
        
        // Hide upload text
//        svFileText.isHidden = true
        isUploadDocument = true
        lblUploadDocument.text = fileURL.lastPathComponent
          
        // Optional image preview
//        if let image = UIImage(contentsOfFile: fileURL.path) {
//            imgDocument.image = image
//        }
        
        print("Selected File:", fileURL)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Document Picker Cancelled")
    }
}

extension AddAttachmentVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addAddtachmentVM.colorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionViewColorTag.dequeueReusableCell(withReuseIdentifier: "CreateFolderColorsCVCell", for: indexPath) as! CreateFolderColorsCVCell
        
        let dicData = addAddtachmentVM.colorList[indexPath.row]
        cell.viewColor.backgroundColor = UIColor(hexString: dicData.hexCode ?? "")
        
        cell.imgSelectedColor.isHidden = selectedIndex != indexPath.row
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let dicData = addAddtachmentVM.colorList[indexPath.row]

        selectedIndex = indexPath.row
        lblColorTagPriority.text = dicData.label ?? ""
        
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
