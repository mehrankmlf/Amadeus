//
//  DetailView.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 5/29/22.
//

import UIKit

final class DetailView: UIView {

     lazy var viewContainer : UIView = {
        let viewContainer = UIView()
        viewContainer.backgroundColor = .white
        viewContainer.layer.borderColor =  UIColor.gray.cgColor
        viewContainer.layer.borderWidth = 1.0
        return viewContainer
    }()
    
     lazy var imageHeader : UIImageView = {
        let imageLogo = UIImageView()
        imageLogo.image = UIImage(named: "airplane")
        imageLogo.contentMode = .scaleAspectFill
        imageLogo.clipsToBounds = true
        return imageLogo
    }()
    
     lazy var lblHeadLine : UILabel = {
        let lblHeadLine = UILabel()
         lblHeadLine.text = "Name : "
         lblHeadLine.textColor = .gray
         lblHeadLine.font = UIFont.boldSystemFont(ofSize: 12)
        return lblHeadLine
    }()
    
     lazy var lblHeadLineDetail : UILabel = {
        let lblHeadLineDetail = UILabel()
         lblHeadLineDetail.text = "unknown"
         lblHeadLineDetail.textColor = .black
         lblHeadLineDetail.numberOfLines = 0
         lblHeadLineDetail.font = UIFont.boldSystemFont(ofSize: 15)
        return lblHeadLineDetail
    }()
    
     lazy var lblSubline : UILabel = {
        let lblSubline = UILabel()
         lblSubline.text = "ChainName : "
         lblSubline.textAlignment = .left
         lblSubline.textColor = .gray
         lblSubline.font = UIFont.boldSystemFont(ofSize: 12)
        return lblSubline
    }()
    
     lazy var lblSublineDetail : UILabel = {
        let lblSublineDetail = UILabel()
         lblSublineDetail.text = "unknown"
         lblSublineDetail.textAlignment = .left
         lblSublineDetail.textColor = .black
         lblSublineDetail.font = UIFont.boldSystemFont(ofSize: 15)
        return lblSublineDetail
    }()
    
     lazy var headLineStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lblHeadLine, lblHeadLineDetail])
        stackView.axis  = .vertical
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
     lazy var subLineStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lblSubline, lblSublineDetail])
        stackView.axis  = .vertical
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
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
    
     func addSubviews() {
         [viewContainer, imageHeader, headLineStackView, subLineStackView]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
     func setupUI() {
        backgroundColor = .background
    }
}

extension DetailView {
    private func makeAutolayout() {
        viewContainer.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        viewContainer.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 30).isActive = true
        viewContainer.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -30).isActive = true
        viewContainer.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        
        imageHeader.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: -25).isActive = true
        imageHeader.leftAnchor.constraint(equalTo: viewContainer.leftAnchor, constant: 30).isActive = true
        imageHeader.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        imageHeader.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        headLineStackView.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 30).isActive = true
        headLineStackView.leftAnchor.constraint(equalTo: viewContainer.leftAnchor, constant: 10).isActive = true
        headLineStackView.rightAnchor.constraint(equalTo: viewContainer.rightAnchor, constant: -10).isActive = true
        
        
        subLineStackView.topAnchor.constraint(equalTo: headLineStackView.bottomAnchor, constant: 10).isActive = true
        subLineStackView.leftAnchor.constraint(equalTo: viewContainer.leftAnchor, constant: 10).isActive = true
        subLineStackView.rightAnchor.constraint(equalTo: viewContainer.rightAnchor, constant: -10).isActive = true
    }
}
