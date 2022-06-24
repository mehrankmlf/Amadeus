//
//  LoginViewController.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 11/2/21.
//

import UIKit
import Combine

class LoginViewController: BaseViewController {
    
    let timer = CountDownTimer(duration: 40)
    var viewModel : LoginViewModel!
    var contentView : LoginView?
    
    var navigateSubject = PassthroughSubject<LoginViewController.Event, Never>()
    
    init(viewModel : LoginViewModel, contentView : LoginView) {
        self.viewModel = viewModel
        self.contentView = contentView
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
        view.backgroundColor = .background
        super.delegate = self
        self.setUpTargets()
        self.bindViewModel()
        self.setupNavigation()
    }
    
    private func setUpTargets() {
        contentView?.btnSubmit.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        contentView?.btnRegister.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        contentView?.txtID.addTarget(self, action: #selector(LoginViewController.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func setupNavigation() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func bindViewModel() {
        
        viewModel?.loadinState
            .sink(receiveValue: { state in
                super.setViewState(state: state, viewContainer: self.view)
            }).store(in: &bag)
        
        viewModel?.$isGetToken
            .sink(receiveValue: { [weak self] event in
                if event {
                    self?.navigateSubject.send(.login)
                }
            }).store(in: &bag)
        
        viewModel?.usernameMessagePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] text in
                
                guard let `self` = self, let view = self.contentView else {
                    return
                }
                
                self.contentView?.lblValidation.text = text
                if text != "" {
                    view.txtID.addRightView(txtField: view.txtID, str: "")
                } else {
                    view.txtID.addRightView(txtField: view.txtID, str: "👍🏻")
                }
            }.store(in: &bag)
        
        viewModel?.formValidation
            .map { $0 != nil}
            .receive(on: RunLoop.main)
            .sink(receiveValue: { (isEnable) in
                if isEnable {
                    //Do Something
                } else {
                    //Do Something
                }
                //Do Something
            })
            .store(in: &bag)
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
                self.contentView?.lblCountDownTimer.text = value
                print(value)
            }.store(in: &bag)
    }
    
    @objc func submitAction() {
        self.viewModel?.getTokenData(grant_type: "client_credentials", client_id: self.contentView?.txtID.text ?? "", client_secret: self.contentView?.txtSecret.text ?? "")
    }
    
    @objc func registerAction() {
        self.navigateSubject.send(.register)
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
        case register
    }
}

