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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let login = LoginVC()
        let homeNavigation = UINavigationController(rootViewController: login)
        homeNavigation.navigationBar.isHidden = true
        self.window?.rootViewController = homeNavigation
        self.window?.makeKeyAndVisible()
        
        IQKeyboardManager.shared.enable = true
        
        // Override point for customization after application launch.
        return true
    }


}

