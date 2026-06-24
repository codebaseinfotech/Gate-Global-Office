//
//  OTPVerificationVC.swift
//  Gate Global
//
//  Created by Poojagabani on 28/04/26.
//

import UIKit

class OTPVerificationVC: UIViewController {

    @IBOutlet weak var viewOTP: OTPFieldView!
    
    var enteredOtp: String = ""
    
    var sendOtpViewModel = ForgotPasswordVM()
    var verifyVM = OTPVerificationVM()
    
    var identifier: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupOtpView()
        bindViewModel()
            
        if !identifier.isEmpty {
            sendOtpViewModel.callSendOTPAPI(identifier: identifier)
        }
        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
        
        // Send OTP
        sendOtpViewModel.successForgotPassword = { [weak self] in
            DispatchQueue.main.async {
                self?.setUpMakeToast(msg: "OTP Sent Successfully")
            }
        }
        
        sendOtpViewModel.failureForgotPassword = { [weak self] message in
            DispatchQueue.main.async {
                self?.setUpMakeToast(msg: message)
            }
        }
        
        // Verify OTP
        verifyVM.successVerifyOTP = { [weak self] in
            DispatchQueue.main.async {
                let vc = HomeVC()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        verifyVM.failureVerifyOTP = { [weak self] message in
            DispatchQueue.main.async {
                self?.setUpMakeToast(msg: message)
            }
        }
    }
    
    func setupOtpView() {
        self.viewOTP.fieldsCount = 6
        self.viewOTP.defaultBackgroundColor = .clear
        self.viewOTP.filledBackgroundColor = .clear
        self.viewOTP.fieldBorderWidth = 1
        self.viewOTP.defaultBorderColor = UIColor.lightGray
        self.viewOTP.filledBorderColor = UIColor(hexString: "#ced4da")
        self.viewOTP.cursorColor = UIColor.black
        self.viewOTP.displayType = .roundedCorner
        self.viewOTP.fieldSize = 50
        self.viewOTP.separatorSpace = 8
        self.viewOTP.shouldAllowIntermediateEditing = false
        self.viewOTP.delegate = self
        
        self.viewOTP.initializeUI()
    }

    @IBAction func tappedVerifyOtp(_ sender: Any) {
        guard enteredOtp.count == 6 else {
            setUpMakeToast(msg: "Enter valid 6-digit OTP")
            return
        }
        
        verifyVM.callVerifyOTPAPI(identifier: identifier, otp: enteredOtp)
    }
    
    @IBAction func tappedResendOtp(_ sender: Any) {
        sendOtpViewModel.callSendOTPAPI(identifier: identifier)
    }
    
    @IBAction func tappedBackToLogin(_ sender: Any) {
        let vc = LoginVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension OTPVerificationVC: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        debugPrint("Has entered all OTP? \(hasEntered)")
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        debugPrint("OTPString: \(otpString)")
        self.enteredOtp = otpString
    }
}
