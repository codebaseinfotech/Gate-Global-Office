//
//  AppDelegate.swift
//  Gate Global
//
//  Created by iMac on 03/11/25.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    static var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setUpLogin()
        
        IQKeyboardManager.shared.enable = true
        
        if GGUtilites.getIsCurrentUser() {
            setUpHome()
        } else {
            setUpLogin()
        }
        // Override point for customization after application launch.
        return true
    }

    func setUpLogin() {
        let login = LoginVC()
        let homeNavigation = UINavigationController(rootViewController: login)
        homeNavigation.navigationBar.isHidden = true
        self.window?.rootViewController = homeNavigation
        self.window?.makeKeyAndVisible()
    }
    
    func setUpHome() {
        let login = HomeVC()
        let homeNavigation = UINavigationController(rootViewController: login)
        homeNavigation.navigationBar.isHidden = true
        self.window?.rootViewController = homeNavigation
        self.window?.makeKeyAndVisible()
    }

}

