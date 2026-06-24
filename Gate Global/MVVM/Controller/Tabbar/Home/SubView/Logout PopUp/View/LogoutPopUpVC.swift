//
//  LogoutPopUpVC.swift
//  Pathrium
//
//  Created by Ankit on 24/06/26.
//

import UIKit

class LogoutPopUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func tappedNo(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    @IBAction func tappedYes(_ sender: Any) {
    }
    
}
