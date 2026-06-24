//
//  LoginVM.swift
//  Gate Global
//
//  Created by Poojagabani on 28/04/26.
//

import Foundation
import Alamofire

class LoginVM {
    
    var successLogin: (() -> Void)?
    var failureLogin: ((String) -> Void)?
    
    var loginResponse: LoginResponseModel?
    
    func callLoginAPI(email: String, password: String) {
        
        APIClient.sharedInstance.showIndicaor()
        
        let params: Parameters = [
            "email": email,
            "password": password
        ]
        
        APIClient.sharedInstance.request(
            method: .post,
            url: .login,
            parameters: params,
            needUserToken: false,
            responseType: LoginResponseModel.self
        ) { [weak self] response, error, statusCode in
            
            APIClient.sharedInstance.hideIndicator()
            
            guard let self = self else { return }
            
            if statusCode == 200 {
                self.loginResponse = response
                
                if response?.success == true {
//                    if let token = response?.data?.accessToken {
//                        GGUtilites.saveCurrentUserToken(token)
//                        GGUtilites.saveIsGetCurrentUser(true)
//                    }
                    self.successLogin?()
                } else {
                    self.failureLogin?(response?.message ?? "")
                }
            } else {
                self.failureLogin?(response?.message ?? error ?? "")
            }
        }
    }
}
