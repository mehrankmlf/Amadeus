//
//  UniversalViewController.swift
//  mediumapp
//
//  Created by Mehran on 6/5/20.
//  Copyright © 2020 MediumApp. All rights reserved.
//

import UIKit
import IHProgressHUD
import Combine
import SwiftKeychainWrapper

enum BaseVCActManager : Int {
    case setNavHeightForNotch = 0
    case hideKeyBoardWhenNeeded = 1
}

protocol ShowEmptyStateProtocol : AnyObject {
    func showEmptyStateView(title: String?, errorType: EmptyStateErrorType, isShow : Bool)
}

class BaseViewController: UIViewController {
    
    var bag = Set<AnyCancellable>()
    var delegate : ShowEmptyStateProtocol?
    
    lazy var alert: AlertHelper = {
        return AlertHelper(vc: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.addIHProgressObservers()
    }
    
    private func addIHProgressObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.handle(_:)), name: NotificationName.IHProgressHUDWillAppear.getNotificationName(), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.handle(_:)), name: NotificationName.IHProgressHUDWillDisappear.getNotificationName(), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.handle(_:)), name: NotificationName.IHProgressHUDDidReceiveTouchEvent.getNotificationName(), object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handle(_ notification: Notification?) {
  
        if notification?.name.rawValue == "IHProgressHUDWillAppear" {
            DispatchQueue.main.async {
                self.view.isUserInteractionEnabled = false
            }
        }
        if notification?.name.rawValue == "IHProgressHUDWillDisappear" {
            DispatchQueue.main.async {
                self.view.isUserInteractionEnabled = true
            }
        }
        if notification?.name.rawValue == "IHProgressHUDDidReceiveTouchEvent" {
            //DO SomeThing if Needded
        }
    }
    
    func baseVCActHelper(navigationView view : UIView? = nil, actType : BaseVCActManager ) {
        switch actType {
        case .setNavHeightForNotch:
            return
        case .hideKeyBoardWhenNeeded:
            return 
        }
    }
}

extension BaseViewController {
     func setViewState(state : ViewModelStatus, viewContainer : UIView) {
        switch state {
        case .loadStart:
            self.alert.Loading()
        case .dismissAlert:
            self.alert.dismiss()
        case .emptyStateHandler(let title, let isShow):
            self.delegate?.showEmptyStateView(title: title, errorType: .serverError, isShow: isShow)
        }
    }
}

extension BaseViewController {
    func setClearAppearanceNavigationBar() {
        if #available(iOS 15, *) {
            // It is recommended by apple to set the appearance for the navigation
            // item when configuring the navigation appearance of a specific view controller
            // https://developer.apple.com/forums/thread/683590
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
            navigationItem.standardAppearance = navigationBarAppearance
            navigationItem.scrollEdgeAppearance = navigationItem.standardAppearance
        } else {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
        }
    }

    func setDefaultAppearanceNavigationBar(with barTintColor: UIColor) {
        if #available(iOS 15, *) {
            // It is recommended by apple to set the appearance for the navigation
            // item when configuring the navigation appearance of a specific view controller
            // https://developer.apple.com/forums/thread/683590
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.backgroundColor = barTintColor
            navigationItem.standardAppearance = navigationBarAppearance
            navigationItem.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        } else {
            navigationController?.navigationBar.barTintColor = barTintColor
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            navigationController?.navigationBar.shadowImage = nil
        }
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}


