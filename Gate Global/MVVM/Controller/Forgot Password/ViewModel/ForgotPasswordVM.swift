//
//  ForgotPasswordVM.swift
//  Gate Global
//
//  Created by Poojagabani on 28/04/26.
//

import Foundation

class ForgotPasswordVM {
    var successForgotPassword: (()->Void)?
    var failureForgotPassword: ((String)->Void)?
    
    var loginResponse: ForgotPassResponseModel?
    
    func callSendOTPAPI(identifier: String) {
        APIClient.sharedInstance.showIndicaor()
        
        let params: [String: Any] = [
            "identifier": identifier,
            "identifier_type": "email",
            "country_code": "SA"
        ]
        
        APIClient.sharedInstance.request(
            method: .post,
            url: .sendOtp,
            parameters: params,
            needUserToken: false,
            responseType: ForgotPassResponseModel.self
        ) { [weak self] response, error, statusCode in
            
            APIClient.sharedInstance.hideIndicator()
            
            guard let self = self else { return }
            
            if let error = error {
                self.failureForgotPassword?(error)
                return
            }
            
            if let data = response {
                self.loginResponse = data
                self.successForgotPassword?()
            } else {
                self.failureForgotPassword?(error ?? "Something went wrong")
            }
        }
    }
}
