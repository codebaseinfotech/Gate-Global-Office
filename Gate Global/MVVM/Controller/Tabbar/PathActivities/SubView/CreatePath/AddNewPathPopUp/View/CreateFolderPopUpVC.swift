//
//  CreateFolderPopUpVC.swift
//  Gate Global
//
//  Created by Poojagabani on 07/05/26.
//

import UIKit

class CreateFolderPopUpVC: UIViewController {
    
    @IBOutlet weak var collectionViewColors: UICollectionView!{
        didSet {
            collectionViewColors.register(UINib(nibName: "CreateFolderColorsCVCell", bundle: nil), forCellWithReuseIdentifier: "CreateFolderColorsCVCell")
            collectionViewColors.delegate = self
            collectionViewColors.dataSource = self
        }
    }

    @IBOutlet weak var lblPriorty: UILabel!
    @IBOutlet weak var svMainColors: UIStackView!
    @IBOutlet weak var viewSelectType: UIView!
    @IBOutlet weak var txtFolderType: UITextField!
    
    var arrColors: [UIColor] = [.red, .orange, .yellow, .green, .blue, .purple, .gray]
    var selectedIndex = -1
    
    var arrFolderTypes = ["Audio", "Document", "Excel", "Image", "Video", "Custom"]
    var arrFolderPriority = ["High Priority", "Medium Priority", "Low Priority", "Live", "Informational", "Confidential", "Archive"]
    
    var dropDown = DropDown()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTypeDropDown()
        // Do any additional setup after loading the view.
    }
    
    func setupTypeDropDown() {
        dropDown.dataSource = arrFolderTypes
        dropDown.direction = .bottom
        dropDown.backgroundColor = .white
        
        dropDown.anchorView = viewSelectType
        
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.txtFolderType.text = item
        }
    }

    @IBAction func tappedDismiss(_ sender: Any) {
        self.dismiss(animated: false)

    }
    
    @IBAction func tappedClose(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    @IBAction func tappedCreate(_ sender: Any) {
    }
    
    @IBAction func tappedSelectType(_ sender: Any) {
        dropDown.anchorView = viewSelectType
        dropDown.show()
    }
    

}

extension CreateFolderPopUpVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionViewColors.dequeueReusableCell(withReuseIdentifier: "CreateFolderColorsCVCell", for: indexPath) as! CreateFolderColorsCVCell
        
        cell.viewColor.backgroundColor = arrColors[indexPath.row]
        cell.imgSelectedColor.isHidden = selectedIndex != indexPath.row
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row
        lblPriorty.text = arrFolderPriority[indexPath.row]
        svMainColors.isHidden = false
        collectionView.reloadData()
    }
    
}

extension CreateFolderPopUpVC: UICollectionViewDelegateFlowLayout {
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
