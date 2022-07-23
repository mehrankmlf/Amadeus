//
//  LoginView.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 5/29/22.
//

import UIKit

final class LoginView: UIView {
    
    private var safeArea: UILayoutGuide!
    private var cornerRadius : CGFloat = 10
    private var padding : CGFloat = 10
    private var fontSize : CGFloat = 15
    
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
        lblTop.textColor = .fontColor
        lblTop.font = UIFont.boldSystemFont(ofSize: 25)
        return lblTop
    }()
    
    lazy var lblID : UILabel = {
        let lblID = UILabel()
        lblID.text = "ClientID"
        lblID.textColor = .fontColor
        lblID.font = UIFont.boldSystemFont(ofSize: fontSize)
        return lblID
    }()
    
    lazy var lblSecret : UILabel = {
        let lblSecret = UILabel()
        lblSecret.text = "ClientSecret"
        lblSecret.textColor = .fontColor
        lblSecret.font = UIFont.boldSystemFont(ofSize: fontSize)
        return lblSecret
    }()
    
    lazy var txtID : UITextField = {
        let txtID = UITextField()
        txtID.textColor = UIColor.gray
        txtID.borderStyle = .line
        txtID.layer.borderColor = UIColor.gray.cgColor
        txtID.layer.borderWidth = 1.0
        txtID.setLeftPaddingPoints(padding)
        return txtID
    }()
    
    lazy var txtSecret : UITextField = {
        let txtSecret = UITextField()
        txtSecret.textColor = UIColor.gray
        txtSecret.borderStyle = .line
        txtSecret.layer.borderColor = UIColor.gray.cgColor
        txtSecret.layer.borderWidth = 1.0
        txtSecret.setLeftPaddingPoints(padding)
        txtSecret.isSecureTextEntry = true
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
        let stackView = UIStackView(arrangedSubviews: [lblID,
                                                       txtID,
                                                       lblSecret,
                                                       txtSecret])
        stackView.axis  = .vertical
        stackView.distribution  = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = padding
        return stackView
    }()
    
    lazy var btnSubmit : UIButton = {
        let btnSubmit = UIButton()
        btnSubmit.setTitle("Login", for: .normal)
        btnSubmit.backgroundColor = .blueBackground
        btnSubmit.setTitleColor(UIColor.white, for: .normal)
        btnSubmit.clipsToBounds = true
        btnSubmit.layer.cornerRadius = cornerRadius
        return btnSubmit
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
        addSubviews()
        makeAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [imageLogo, lblTop, statsView, btnSubmit]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setupUI() {
        backgroundColor = .whiteBackground
        safeArea = self.safeAreaLayoutGuide
    }
}

extension LoginView {
    private func makeAutolayout() {
        imageLogo.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50).isActive = true
        imageLogo.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 30).isActive = true
        imageLogo.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -30).isActive = true
        imageLogo.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        lblTop.topAnchor.constraint(equalTo: imageLogo.bottomAnchor, constant: 40).isActive = true
        lblTop.leadingAnchor.constraint(equalTo: imageLogo.leadingAnchor).isActive = true
        lblTop.trailingAnchor.constraint(equalTo: imageLogo.trailingAnchor).isActive = true
        lblTop.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        txtID.heightAnchor.constraint(equalToConstant: 40).isActive = true
        txtSecret.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        statsView.topAnchor.constraint(equalTo: lblTop.bottomAnchor, constant: 15).isActive = true
        statsView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 30).isActive = true
        statsView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -30).isActive = true
        
        btnSubmit.topAnchor.constraint(equalTo: statsView.bottomAnchor, constant: 50).isActive = true
        btnSubmit.leadingAnchor.constraint(equalTo: statsView.leadingAnchor).isActive = true
        btnSubmit.trailingAnchor.constraint(equalTo: statsView.trailingAnchor).isActive = true
        btnSubmit.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
