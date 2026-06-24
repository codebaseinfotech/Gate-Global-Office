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
    
    var viewModel = LoginVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmail.text = "kaushik.vnerds@gmail.com"
        txtPassword.text = "123456"

        bindViewModel()
        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
        viewModel.successLogin = { [weak self] in
            DispatchQueue.main.async {
                let vc = OTPVerificationVC()
                vc.identifier = self?.txtEmail.text ?? ""
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        viewModel.failureLogin = { [weak self] message in
            DispatchQueue.main.async {
                self?.setUpMakeToast(msg: message)
            }
        }
    }
    
    @IBAction func clickedForgetPass(_ sender: Any) {
        let vc = ForgotPasswordVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickedLogin(_ sender: Any) {
        guard let email = txtEmail.text, !email.isEmpty else {
            setUpMakeToast(msg: "Enter email")
            return
        }
        
        guard let password = txtPassword.text, !password.isEmpty else {
            setUpMakeToast(msg: "Enter password")
            return
        }
        
        if password.count < 6 {
            setUpMakeToast(msg: "Password must be at least 6 characters")
            return
        }
        
        viewModel.callLoginAPI(email: email, password: password)
    }
    
    @IBAction func clickedGoogle(_ sender: Any) {
        
    }
    
}
