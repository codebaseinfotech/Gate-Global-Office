//
//  AddNewPathPopUpVC.swift
//  Gate Global
//
//  Created by Poojagabani on 05/05/26.
//

import UIKit

class AddNewPathPopUpVC: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPathName: UILabel!
    @IBOutlet weak var txtPathName: UITextField!
    
    var onSubmit: ((String) -> Void)?
    var actionType: PathAction = .addNewPath
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
            switch actionType {
            case .addNewPath:
                lblTitle.text = "Add New Path"
                lblPathName.text = "Path Name *"
                txtPathName.placeholder = "Enter path name"

            case .addNewTrack:
                lblTitle.text = "Add New Track"
                lblPathName.text = "Track Name"
                txtPathName.placeholder = "Enter track name"

            case .addNewDestination:
                lblTitle.text = "Add New Destination"
                lblPathName.text = "Destination"
                txtPathName.placeholder = "Enter destination name"
            }
        }

    @IBAction func tappedClose(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    @IBAction func tappedCloseBtn(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    @IBAction func tappedSubmit(_ sender: Any) {
        guard let text = txtPathName.text, !text.isEmpty else { return }
        
        onSubmit?(text)
        self.dismiss(animated: false)
    }
    
}
