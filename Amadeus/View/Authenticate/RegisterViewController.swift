//
//  RegisterViewController.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 12/25/21.
//

import UIKit
import Combine

class RegisterViewController: BaseViewController {
    
    var viewModel : RegisterViewModel?
    var contentView : RegisterView?
    var navigationSubject = PassthroughSubject<RegisterViewController.Event, Never>()
    
    init(viewModel : RegisterViewModel, contentView : RegisterView) {
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
        self.setUpTargets()
        self.setupNavigation()
    }
    
    private func setUpTargets() {
        contentView?.btnSubmit.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        contentView?.btnDismiss.addTarget(self, action: #selector(submitDismiss), for: .touchUpInside)
    }
    
    private func setupNavigation() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func submitAction() {
        self.alert.error(message: "Comming Soon!")
    }
    
    @objc func submitDismiss() {
        self.navigationSubject.send(.onBack)
    }
}

extension RegisterViewController {
    enum Event {
        case register
        case onBack
    }
}


