//
//  UIViewController+SideMenu.swift
//  Gate Global
//
//  Created by Ankit on 24/06/26.
//

import Foundation
import UIKit
import ObjectiveC

private var sideMenuKey: UInt8 = 0
private var overlayKey: UInt8 = 0

extension UIViewController {
    
    var sideMenuVC: SideMenuVC? {
        get {
            objc_getAssociatedObject(self, &sideMenuKey) as? SideMenuVC
        }
        set {
            objc_setAssociatedObject(self, &sideMenuKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var overlayView: UIView? {
        get {
            objc_getAssociatedObject(self, &overlayKey) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &overlayKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func showSideMenu() {
        guard sideMenuVC == nil else {
            hideSideMenu()
            return
        }
        
        let menuWidth = view.frame.width - 80
        let overlay = UIView(frame: view.bounds)
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(closeMenuFromOverlay)
        )
        overlay.addGestureRecognizer(tap)
        view.addSubview(overlay)
        overlayView = overlay
        
        let menuVC = SideMenuVC(nibName: "SideMenuVC", bundle: nil)
        
        addChild(menuVC)
        
        menuVC.view.frame = CGRect(
            x: -menuWidth,
            y: 0,
            width: menuWidth,
            height: view.frame.height
        )
        
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        UIView.animate(withDuration: 0.3) {
            menuVC.view.frame.origin.x = 0
        }
        sideMenuVC = menuVC
    }
    
    @objc func closeMenuFromOverlay() {
        hideSideMenu()
    }
    
    func hideSideMenu() {
        guard let menuVC = sideMenuVC else { return }
        
        let menuWidth = view.frame.width - 80
        UIView.animate(withDuration: 0.3, animations: {
            
            menuVC.view.frame.origin.x = -menuWidth
            self.overlayView?.alpha = 0
        }) { _ in
            menuVC.willMove(toParent: nil)
            menuVC.view.removeFromSuperview()
            menuVC.removeFromParent()
            
            self.overlayView?.removeFromSuperview()
            self.sideMenuVC = nil
            self.overlayView = nil
        }
    }
}
