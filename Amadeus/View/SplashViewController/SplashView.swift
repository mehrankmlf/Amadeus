//
//  SplashView.swift
//  SappPlus
//
//  Created by Mehran on 3/5/1401 AP.
//

import UIKit

final class SplashView: UIView {
    
   lazy var viewContainer : UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        return containerView
    }()
    
    lazy var imageMain : UIImageView = {
        let imageMain = UIImageView()
        imageMain.contentMode = .scaleToFill
        imageMain.image = UIImage(named: "amadeus")
        return imageMain
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
        [viewContainer, imageMain]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setupUI() {
        backgroundColor = .background
    }
}

extension SplashView {
    private func makeAutolayout() {
        NSLayoutConstraint.activate([
            viewContainer.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            viewContainer.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            viewContainer.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageMain.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            imageMain.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor),
            imageMain.heightAnchor.constraint(equalToConstant: 200),
            imageMain.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
}
