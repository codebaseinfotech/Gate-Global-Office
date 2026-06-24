//
//  GGUtilites.swift
//  Gate Global
//
//  Created by Poojagabani on 28/04/26.
//

import Foundation
import UIKit

class GGUtilites {
    static let userDefaults = UserDefaults.standard
    
    class func saveIsGetCurrentUser(_ isUserLogin: Bool) {
        userDefaults.set(isUserLogin, forKey: "isUserLogin")
    }
    
    class func getIsCurrentUser() -> Bool {
        return userDefaults.bool(forKey: "isUserLogin")
    }
    
    class func saveCurrentUserToken(_ access_token: String) {
        userDefaults.set(access_token, forKey: "access_token")
    }
    
    class func getCurrentUserToken() -> String {
        return userDefaults.string(forKey: "access_token") ?? ""
    }
}
