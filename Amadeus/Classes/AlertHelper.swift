//
//  AlertHelper.swift
//  mediumapp
//
//  Created by Mehran on 9/25/20.
//  Copyright © 2020 MediumApp. All rights reserved.
//
import IHProgressHUD
import UIKit

struct AlertHelper : AlertAdapter {
    
    var vc : UIViewController?
    var view : UIView?
    
    init(vc:UIViewController) {
        self.vc = vc
    }
    
    init(view:UIView) {
        self.view = view
    }
    
    //MARK: - Implement Loading
    
    func Loading() {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                IHProgressHUD.set(containerView: (self.vc?.view ?? self.view))
                IHProgressHUD.show()
            }
        }
    }
    
    //MARK: - Implement Dismiss
    
    func dismiss() {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                IHProgressHUD.dismiss()
            }
        }
    }
    
    //MARK: - Implement Loading With Message
    
    func LoadingWithMessage(message : String) {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                IHProgressHUD.set(containerView: (self.vc?.view ?? self.view))
                IHProgressHUD.show(withStatus: message)
            }
        }
    }
    
    //MARK: - Implement Success With Message
    
    func success(message : String) {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                IHProgressHUD.set(containerView: (self.vc?.view ?? self.view))
                IHProgressHUD.showSuccesswithStatus(message)
            }
        }
    }
    
    //MARK: - Implement Error With Message
    
    func error(message : String) {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                IHProgressHUD.set(containerView: (self.vc?.view ?? self.view))
                IHProgressHUD.showInfowithStatus(message)
            }
        }
    }
}
