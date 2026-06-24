//
//  ForgotPasswordVC.swift
//  Gate Global
//
//  Created by Poojagabani on 28/04/26.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    
    var viewModel = ForgotPasswordVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
        
        viewModel.successForgotPassword = { [weak self] in
            DispatchQueue.main.async {
                let vc = OTPVerificationVC()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        viewModel.failureForgotPassword = { [weak self] message in
            DispatchQueue.main.async {
                self?.setUpMakeToast(msg: message)
            }
        }
    }

    @IBAction func tappedSendResetLink(_ sender: Any) {
        guard let email = txtEmail.text, !email.isEmpty else {
            self.setUpMakeToast(msg: "Enter email")
            return
        }
        
        viewModel.callSendOTPAPI(identifier: email)
    }
    
    @IBAction func tappedBackToLogin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
