//
//  UniversalViewController.swift
//  Amadeus
//
//  Created by Mehran on 6/5/20.
//  Copyright © 2020 MediumApp. All rights reserved.
//

import UIKit
import IHProgressHUD
import Combine
import SwiftKeychainWrapper

enum BaseVCActManager: Int {
    case setNavHeightForNotch = 0
    case hideKeyBoardWhenNeeded = 1
}

protocol ShowEmptyStateProtocol: AnyObject {
    func showEmptyStateView(title: String?, errorType: EmptyStateErrorType, isShow: Bool)
}

class BaseViewController<ViewModel: StandardBaseViewModel>: UIViewController {
    
    var viewModel: ViewModel
    var reachability =  Reachability()
    var subscriber = Set<AnyCancellable>()
    weak var delegate: ShowEmptyStateProtocol?
    
    lazy var alert: AlertHelper = {
        return AlertHelper(vc: self)
    }()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("use init() method")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteBackground
        self.handleViewState()
        self.setReachability()
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
    
    func baseVCActHelper(navigationView view: UIView? = nil, actType: BaseVCActManager ) {
        switch actType {
        case .setNavHeightForNotch:
            return
        case .hideKeyBoardWhenNeeded:
            return
        }
    }
    
    //Check Internet Connection Availability
    private func setReachability() {
        reachability?.whenUnreachable = { [weak self] _ in
            guard let self = self else { return }
            self.showAlertWith(message: "NetwortErro")
        }
        try? reachability?.startNotifier()
    }
    
    func handleViewState() {
        self.viewModel.loadinState
            .sink { [weak self] state in
                self?.setViewState(state: state)
            }.store(in: &subscriber)
    }
}

extension BaseViewController {
    func setViewState(state: ViewModelStatus) {
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
    
    func setNavigationvBarHidden() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
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
            //            navigationBarAppearance.configureWithDefaultBackground()
            navigationBarAppearance.backgroundColor = barTintColor
            // This will alter the navigation bar title appearance
            let titleAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold),
                                  NSAttributedString.Key.foregroundColor: UIColor(red: 0/255, green: 94/255, blue: 184/255, alpha: 1.0)] //alter to fit your needs
            navigationBarAppearance.titleTextAttributes = titleAttribute
            navigationItem.standardAppearance = navigationBarAppearance
            navigationItem.compactAppearance = navigationBarAppearance
            navigationItem.scrollEdgeAppearance = navigationBarAppearance
        } else {
            navigationController?.navigationBar.barTintColor = barTintColor
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            navigationController?.navigationBar.shadowImage = nil
        }
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
