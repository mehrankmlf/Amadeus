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
    
     lazy var lblDestination : UILabel = {
        let lblDestination = UILabel()
        lblDestination.text = "Destination : "
        lblDestination.textAlignment = .left
        lblDestination.textColor = .black
        lblDestination.font = UIFont.boldSystemFont(ofSize: 15)

        return lblDestination
    }()
    
     lazy var lblDestinationDetail : UILabel = {
        let lblDestinationDetail = UILabel()
        lblDestinationDetail.text = "Destination"
        lblDestinationDetail.textAlignment = .left
        lblDestinationDetail.textColor = .black
        lblDestinationDetail.font = UIFont.boldSystemFont(ofSize: 15)
        return lblDestinationDetail
    }()
    
     lazy var lblDeparture : UILabel = {
        let lblDestination = UILabel()
        lblDestination.text = "DepartureDate : "
        lblDestination.textAlignment = .left
        lblDestination.textColor = .black
        lblDestination.font = UIFont.boldSystemFont(ofSize: 15)
        return lblDestination
    }()
    
     lazy var lblDeparturDetail : UILabel = {
        let lblDestinationDetail = UILabel()
        lblDestinationDetail.text = "Destination"
        lblDestinationDetail.textAlignment = .left
        lblDestinationDetail.textColor = .black
        lblDestinationDetail.font = UIFont.boldSystemFont(ofSize: 15)
        return lblDestinationDetail
    }()
    
     lazy var destinatioStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lblDestination, lblDestinationDetail])
        stackView.axis  = .horizontal
        stackView.distribution  = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
     lazy var departureStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lblDeparture, lblDeparturDetail])
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
    
     func addSubviews() {
         [viewContainer, imageHeader, destinatioStackView, departureStackView]
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
        viewContainer.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        viewContainer.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 30).isActive = true
        viewContainer.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -30).isActive = true
        viewContainer.heightAnchor.constraint(equalToConstant: 110.0).isActive = true
        
        imageHeader.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: -25).isActive = true
        imageHeader.leftAnchor.constraint(equalTo: viewContainer.leftAnchor, constant: 30).isActive = true
        imageHeader.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        imageHeader.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        destinatioStackView.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 30).isActive = true
        destinatioStackView.leftAnchor.constraint(equalTo: viewContainer.leftAnchor, constant: 10).isActive = true
        destinatioStackView.rightAnchor.constraint(greaterThanOrEqualTo: viewContainer.leftAnchor, constant: -10).isActive = true
        destinatioStackView.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        departureStackView.topAnchor.constraint(equalTo: destinatioStackView.bottomAnchor, constant: 5).isActive = true
        departureStackView.leftAnchor.constraint(equalTo: viewContainer.leftAnchor, constant: 10).isActive = true
        departureStackView.rightAnchor.constraint(greaterThanOrEqualTo: viewContainer.leftAnchor, constant: -10).isActive = true
        departureStackView.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
    }
}
