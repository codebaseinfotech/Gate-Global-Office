//
//  LoginVC.swift
//  Gate Global
//
//  Created by iMac on 04/11/25.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var lblDis: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var lblOR: UILabel!
    @IBOutlet weak var lblGoogle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func clickedMenubar(_ sender: Any) {
        
    }
    
    @IBAction func clickedForgetPass(_ sender: Any) {
        
    }
    
    @IBAction func clickedLogin(_ sender: Any) {
        let vc = HomeVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickedGoogle(_ sender: Any) {
        
    }
    
}
