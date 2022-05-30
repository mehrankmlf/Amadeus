//
//  LoginView.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 5/29/22.
//

import UIKit

final class LoginView: UIView {
    
    lazy var imageLogo : UIImageView = {
        let imageLogo = UIImageView()
        imageLogo.image = UIImage(named: "amadeus_logo")
        imageLogo.contentMode = .scaleAspectFill
        imageLogo.clipsToBounds = true
        return imageLogo
    }()
    
    lazy var lblTop : UILabel = {
        let lblTop = UILabel()
        lblTop.text = "Sign in"
        lblTop.textColor = UIColor(red: 54.0/255, green: 94.0/255, blue: 180.0/255, alpha: 1.0)
        lblTop.font = UIFont.boldSystemFont(ofSize: 25)
        return lblTop
    }()
    
    lazy var lblID : UILabel = {
        let lblID = UILabel()
        lblID.text = "ClientID"
        lblID.textColor = UIColor(red: 54.0/255, green: 94.0/255, blue: 180.0/255, alpha: 1.0)
        lblID.font = UIFont.boldSystemFont(ofSize: 15)
        return lblID
    }()
    
    lazy var lblSecret : UILabel = {
        let lblSecret = UILabel()
        lblSecret.text = "ClientSecret"
        lblSecret.textColor = UIColor(red: 54.0/255, green: 94.0/255, blue: 180.0/255, alpha: 1.0)
        lblSecret.font = UIFont.boldSystemFont(ofSize: 15)
        return lblSecret
    }()
    
    lazy var txtID : UITextField = {
        let txtID = UITextField()
        txtID.textColor = UIColor.gray
        txtID.borderStyle = .line
        txtID.layer.borderColor = UIColor.gray.cgColor
        txtID.layer.borderWidth = 1.0
        return txtID
    }()
    
    lazy var txtSecret : UITextField = {
        let txtSecret = UITextField()
        txtSecret.textColor = UIColor.gray
        txtSecret.borderStyle = .line
        txtSecret.layer.borderColor = UIColor.gray.cgColor
        txtSecret.layer.borderWidth = 1.0
        return txtSecret
    }()
    
    lazy var lblValidation : UILabel = {
        let lblValidation = UILabel()
        lblValidation.textColor = UIColor.gray
        return lblValidation
    }()
    
    lazy var lblCountDownTimer : UILabel = {
        let lblCountDownTimer = UILabel()
        lblCountDownTimer.textColor = UIColor.gray
        return lblCountDownTimer
    }()
    
    lazy var statsView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lblID, txtID, lblSecret, txtSecret])
        stackView.axis  = .vertical
        stackView.distribution  = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var btnSubmit : UIButton = {
        let btnSubmit = UIButton()
        btnSubmit.setTitle("Login", for: .normal)
        btnSubmit.backgroundColor = UIColor(red: 2.0/255, green: 94.0/255, blue: 184.0/255, alpha: 1.0)
        btnSubmit.setTitleColor(UIColor.white, for: .normal)
        btnSubmit.clipsToBounds = true
        btnSubmit.layer.cornerRadius = 10.0
        return btnSubmit
    }()
    
    private lazy var lblSignup : UILabel = {
        let lblSignup = UILabel()
        lblSignup.text = "Don't have an account?"
        lblSignup.textColor = UIColor(red: 54.0/255, green: 94.0/255, blue: 180.0/255, alpha: 1.0)
        lblSignup.font = UIFont.boldSystemFont(ofSize: 12)
        return lblSignup
    }()
    
    lazy var btnRegister : UIButton = {
        let btnRegister = UIButton()
        btnRegister.setTitle("Register", for: .normal)
        btnRegister.setTitleColor(UIColor(red: 54.0/255, green: 94.0/255, blue: 180.0/255, alpha: 1.0), for: .normal)
        btnRegister.titleLabel?.font = .systemFont(ofSize: 12)
        btnRegister.clipsToBounds = true
        return btnRegister
    }()
    
    lazy var registerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lblSignup, btnRegister])
        stackView.axis  = .horizontal
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
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
    
    private func addSubviews() {
        [imageLogo, lblTop, statsView, btnSubmit, registerStackView]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setupUI() {
        self.txtID.text = "sDi2yLIAAKqAfrZKGJU6Zassx3TnDboJ"
        self.txtSecret.text = "D347OAVE7ZJ8vwLR"
        backgroundColor = .background
    }
}

extension LoginView {
    private func makeAutolayout() {
        imageLogo.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        imageLogo.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 30).isActive = true
        imageLogo.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -30).isActive = true
        imageLogo.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        lblTop.topAnchor.constraint(equalTo: imageLogo.bottomAnchor, constant: 40).isActive = true
        lblTop.leadingAnchor.constraint(equalTo: imageLogo.leadingAnchor).isActive = true
        lblTop.trailingAnchor.constraint(equalTo: imageLogo.trailingAnchor).isActive = true
        lblTop.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        txtID.heightAnchor.constraint(equalToConstant: 40).isActive = true
        txtSecret.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        statsView.topAnchor.constraint(equalTo: lblTop.bottomAnchor, constant: 15).isActive = true
        statsView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 30).isActive = true
        statsView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -30).isActive = true
        
        btnSubmit.topAnchor.constraint(equalTo: statsView.bottomAnchor, constant: 50).isActive = true
        btnSubmit.leadingAnchor.constraint(equalTo: statsView.leadingAnchor).isActive = true
        btnSubmit.trailingAnchor.constraint(equalTo: statsView.trailingAnchor).isActive = true
        btnSubmit.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        registerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        registerStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
}
