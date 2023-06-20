//
//  LoginViewController.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 11/2/21.
//

import UIKit
import Combine

final class LoginViewController: BaseViewController<LoginViewModel> {
    
    let clientId = "Your Amadeus Client Id"
    
    let timer = CountDownTimer(duration: 40)
    var contentView = LoginView()
    var obfuscator = Obfuscator()
    
    var navigateSubject = PassthroughSubject<LoginViewController.Event, Never>()

    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.delegate = self
        self.setUpTargets()
        self.bindViewModel()
        self.setupNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.contentView.txtID.text = clientId
        self.contentView.txtSecret.text = self.fetchSecret()
    }
    
    private func setUpTargets() {
        contentView.btnSubmit.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
    }
    
    private func setupNavigation() {
        super.setNavigationvBarHidden()
    }
    
    private func fetchSecret() -> String? {
        return obfuscator.reveal(key: ObfuscatedConstants.obfuscatedSecret)
    }
    
    private func bindViewModel() {
        
        contentView.txtID.textPublisher
            .receive(on: Scheduler.mainThread)
            .assign(to: \.userName, on: viewModel)
            .store(in: &subscriber)
        
        viewModel.$isGetToken
            .sink(receiveValue: { [weak self] event in
                if event {
                    self?.navigateSubject.send(.login)
                }
            }).store(in: &subscriber)
        
        viewModel.usernameMessagePublisher
            .receive(on: Scheduler.mainScheduler)
            .sink { [weak self] text in
                
                guard let `self` = self else {
                    return
                }
                
                self.contentView.lblValidation.text = text
                if text != "" {
                    self.contentView.txtID.addRightView(txtField: self.contentView.txtID, str: "")
                } else {
                    self.contentView.txtID.addRightView(txtField: self.contentView.txtID, str: "👍🏻")
                }
            }.store(in: &subscriber)
        
        viewModel.formValidation
            .map { $0 != nil}
            .receive(on: Scheduler.mainScheduler)
            .sink(receiveValue: { (isEnable) in
                if isEnable {
                    //Do Something
                } else {
                    //Do Something
                }
                //Do Something
            })
            .store(in: &subscriber)
    }
    
    func handleTimer() {
        self.timer
            .map { String(describing: $0) }
            .sink { value in
                switch value {
                case .finished:
                    // Do Something
                    return
                }
            } receiveValue: { value in
                self.contentView.lblCountDownTimer.text = value
            }.store(in: &subscriber)
    }
    
    @objc
    func submitAction() {
        viewModel.getTokenData(grant_type: "client_credentials", client_id: clientId, client_secret: fetchSecret() ?? "")
    }
}

extension LoginViewController: ShowEmptyStateProtocol {
    func showEmptyStateView(title: String?, errorType: EmptyStateErrorType, isShow: Bool) {
        super.alert.error(message: title ?? "")
    }
}

extension LoginViewController {
    enum Event {
        case login
    }
}

