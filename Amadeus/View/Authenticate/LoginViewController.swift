//
//  LoginViewController.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 11/2/21.
//

import UIKit
import Combine

class LoginViewController: BaseViewController {
    
    let clientId = "sDi2yLIAAKqAfrZKGJU6Zassx3TnDboJ"
    
    let timer = CountDownTimer(duration: 40)
    var viewModel : LoginViewModel!
    var contentView = LoginView()
    var obfuscator : Obfuscator!
    
    var navigateSubject = PassthroughSubject<LoginViewController.Event, Never>()
    
    init(viewModel : LoginViewModel,
         obfuscator : Obfuscator) {
        self.viewModel = viewModel
        self.obfuscator = obfuscator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteBackground
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
        contentView.txtID.addTarget(self, action: #selector(LoginViewController.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func setupNavigation() {
        super.setNavigationvBarHidden()
    }
    
    private func fetchSecret() -> String? {
        return obfuscator?.reveal(key: ObfuscatedConstants.obfuscatedSecret)
    }
    
    private func bindViewModel() {
        
//        viewModel?.loadinState
//            .sink(receiveValue: { state in
//                super.setViewState(state: state, viewContainer: self.view)
//            }).store(in: &subscriber)
//        
        viewModel?.$isGetToken
            .sink(receiveValue: { [weak self] event in
                if event {
                    self?.navigateSubject.send(.login)
                }
            }).store(in: &subscriber)
        
        viewModel?.usernameMessagePublisher
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
        
        viewModel?.formValidation
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
                print(value)
            }.store(in: &subscriber)
    }
    
    @objc func submitAction() {
        self.viewModel?.getTokenData(grant_type: "client_credentials", client_id: clientId, client_secret: fetchSecret() ?? "")
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.viewModel?.userName = textField.text ?? ""
    }
}

extension LoginViewController : ShowEmptyStateProtocol {
    
    func showEmptyStateView(title: String?, errorType: EmptyStateErrorType, isShow: Bool) {
        super.alert.error(message: title ?? "")
    }
}

extension LoginViewController {
    enum Event {
        case login
    }
}

