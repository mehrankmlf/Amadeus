//
//  RegisterView.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 5/29/22.
//

import UIKit

class RegisterView: UIView {
    
    lazy var lblRegister : UILabel = {
        let lblTop = UILabel()
        lblTop.text = "Register"
        lblTop.textColor = UIColor(red: 54.0/255, green: 94.0/255, blue: 180.0/255, alpha: 1.0)
        lblTop.font = UIFont.boldSystemFont(ofSize: 25)
        return lblTop
    }()
    
    lazy var lblFullName : UILabel = {
        let lblTop = UILabel()
        lblTop.text = "Full Name"
        lblTop.textColor = UIColor(red: 54.0/255, green: 94.0/255, blue: 180.0/255, alpha: 1.0)
        lblTop.font = UIFont.boldSystemFont(ofSize: 15)
        return lblTop
    }()
    
    lazy var lblEmail : UILabel = {
        let lblTop = UILabel()
        lblTop.text = "Email"
        lblTop.textColor = UIColor(red: 54.0/255, green: 94.0/255, blue: 180.0/255, alpha: 1.0)
        lblTop.font = UIFont.boldSystemFont(ofSize: 15)
        return lblTop
    }()
    
    lazy var lblPassword : UILabel = {
        let lblTop = UILabel()
        lblTop.text = "Password"
        lblTop.textColor = UIColor(red: 54.0/255, green: 94.0/255, blue: 180.0/255, alpha: 1.0)
        lblTop.font = UIFont.boldSystemFont(ofSize: 15)
        return lblTop
    }()
    
    lazy var lblConfirmPassword : UILabel = {
        let lblTop = UILabel()
        lblTop.text = "ConfirmPassword"
        lblTop.textColor = UIColor(red: 54.0/255, green: 94.0/255, blue: 180.0/255, alpha: 1.0)
        lblTop.font = UIFont.boldSystemFont(ofSize: 15)
        return lblTop
    }()
    
    lazy var txtFullName : UITextField = {
        let txtUserName = UITextField()
        txtUserName.textColor = UIColor.gray
        txtUserName.borderStyle = .line
        txtUserName.layer.borderColor = UIColor.gray.cgColor
        txtUserName.layer.borderWidth = 1.0
        return txtUserName
    }()
    
    lazy var txtEmail : UITextField = {
        let txtUserName = UITextField()
        txtUserName.textColor = UIColor.gray
        txtUserName.borderStyle = .line
        txtUserName.layer.borderColor = UIColor.gray.cgColor
        txtUserName.layer.borderWidth = 1.0
        return txtUserName
    }()
    
    lazy var txtPassword : UITextField = {
        let txtUserName = UITextField()
        txtUserName.textColor = UIColor.gray
        txtUserName.borderStyle = .line
        txtUserName.layer.borderColor = UIColor.gray.cgColor
        txtUserName.layer.borderWidth = 1.0
        return txtUserName
    }()
    
    lazy var txtConfirmPassword : UITextField = {
        let txtUserName = UITextField()
        txtUserName.textColor = UIColor.gray
        txtUserName.borderStyle = .line
        txtUserName.layer.borderColor = UIColor.gray.cgColor
        txtUserName.layer.borderWidth = 1.0
        return txtUserName
    }()
    
    lazy var statsView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lblFullName,
                                                       txtFullName,
                                                       lblEmail,
                                                       txtEmail,
                                                       lblPassword,
                                                       txtPassword,
                                                       lblConfirmPassword,
                                                       txtConfirmPassword])
        stackView.axis  = .vertical
        stackView.distribution  = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var btnSubmit : UIButton = {
        let btnSubmit = UIButton()
        btnSubmit.setTitle("Register", for: .normal)
        btnSubmit.backgroundColor = UIColor(red: 2.0/255, green: 94.0/255, blue: 184.0/255, alpha: 1.0)
        btnSubmit.setTitleColor(UIColor.white, for: .normal)
        btnSubmit.clipsToBounds = true
        btnSubmit.layer.cornerRadius = 10.0
        return btnSubmit
    }()
    
    lazy var btnDismiss : UIButton = {
        let btnSubmit = UIButton()
        btnSubmit.setTitle("Back", for: .normal)
        btnSubmit.setTitleColor(UIColor.gray, for: .normal)
        btnSubmit.clipsToBounds = true
        return btnSubmit
    }()
    
    init() {
        super.init(frame: .zero)
        
        addSubviews()
        makeAutolayout()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        [lblRegister, statsView, btnSubmit, btnDismiss]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    func setupUI() {
        backgroundColor = .background
    }
}

extension RegisterView {
    func makeAutolayout() {
        lblRegister.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        lblRegister.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 30).isActive = true
        lblRegister.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -30).isActive = true
        lblRegister.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        statsView.topAnchor.constraint(equalTo: lblRegister.bottomAnchor, constant: 20).isActive = true
        statsView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 30).isActive = true
        statsView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -30).isActive = true
        
        btnSubmit.topAnchor.constraint(equalTo: statsView.bottomAnchor, constant: 50).isActive = true
        btnSubmit.leadingAnchor.constraint(equalTo: statsView.leadingAnchor).isActive = true
        btnSubmit.trailingAnchor.constraint(equalTo: statsView.trailingAnchor).isActive = true
        btnSubmit.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        btnDismiss.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        btnDismiss.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        btnDismiss.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
