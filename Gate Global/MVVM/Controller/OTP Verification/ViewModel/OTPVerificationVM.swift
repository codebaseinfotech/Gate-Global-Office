//
//  OTPVerificationVM.swift
//  Gate Global
//
//  Created by Poojagabani on 29/04/26.
//

import Foundation
import Alamofire

class OTPVerificationVM {
    
    var successVerifyOTP: (() -> Void)?
    var failureVerifyOTP: ((String) -> Void)?
    
    var loginResponse: LoginResponseModel?
    
    func callVerifyOTPAPI(identifier: String, otp: String) {
        
        APIClient.sharedInstance.showIndicaor()
        
        let params: Parameters = [
            "identifier": identifier,
            "otp": otp,
            "identifier_type": "email",
            "country_code": "SA"
        ]
        
        APIClient.sharedInstance.request(
            method: .post,
            url: .verifyOtp,
            parameters: params,
            needUserToken: false,
            responseType: LoginResponseModel.self
        ) { [weak self] response, error, statusCode in
            
            APIClient.sharedInstance.hideIndicator()
            
            guard let self = self else { return }
            
            if statusCode == 200 {
                
                self.loginResponse = response
                
                if response?.success == true {
                    
                    GGUtilites.saveCurrentUserToken(response?.data?.accessToken ?? "")
                    GGUtilites.saveCurrentUser(response?.data?.user)
                    GGUtilites.saveIsGetCurrentUser(true)
                    
                    self.successVerifyOTP?()
                    
                } else {
                    self.failureVerifyOTP?(response?.message ?? "")
                }
                
            } else {
                self.failureVerifyOTP?(response?.message ?? "")
            }
        }
    }
}
