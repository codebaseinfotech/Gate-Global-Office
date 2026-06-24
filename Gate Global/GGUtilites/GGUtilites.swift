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
    
    class func saveCurrentUser(_ user: User?) {
        guard let user = user else { return }
        
        do {
            let data = try PropertyListEncoder().encode(user)
            userDefaults.set(data, forKey: "currentUser")
        } catch {
            print("❌ Failed to save user: \(error)")
        }
    }
    
    class func getCurrentUser() -> User? {
        guard let data = userDefaults.data(forKey: "currentUser") else {
            return nil
        }
        
        do {
            return try PropertyListDecoder().decode(User.self, from: data)
        } catch {
            print("❌ Failed to decode user: \(error)")
            return nil
        }
    }
    
    class func logout() {
        userDefaults.removeObject(forKey: "access_token")
        userDefaults.removeObject(forKey: "currentUser")
        userDefaults.set(false, forKey: "isUserLogin")
        userDefaults.synchronize()
    }
}
