//
//  MainTableViewCell.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 1/16/22.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    private enum Constants {
        
        static let fontSize : CGFloat = 15
        static let padding : CGFloat = 10
        
        // MARK: contentView layout constants
        static let contentViewCornerRadius: CGFloat = 10.0
        
        // MARK: profileImageView layout constants
        
        static let generalPadding : CGFloat = 10.0
        static let generalHeight  : CGFloat = 25.0
    }
    
    static let cellId = "cellId"
    
    private lazy var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .whiteBackground
        view.clipsToBounds = true
        view.dropShadow()
        view.roundCorners([.topLeft, .bottomLeft], radius: Constants.contentViewCornerRadius)
        return view
    }()
    
    private lazy var rightSideView : UIView = {
        let view = UIView()
        view.backgroundColor = .blueBackground
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var lblRightSideView : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    lazy var imageDiscount : UIImageView = {
        let imageMain = UIImageView()
        imageMain.contentMode = .scaleAspectFill
        imageMain.image = UIImage(named: "discount")
        return imageMain
    }()
    
    private lazy var lblTitle : UILabel = {
        let lblTitle = UILabel()
        lblTitle.textColor = UIColor.black
        lblTitle.font = UIFont.systemFont(ofSize: Constants.fontSize)
        return lblTitle
    }()
    
    private lazy var lblHeadLine : UILabel = {
        let lblHeadLine = UILabel()
        lblHeadLine.textColor = UIColor.black
        lblHeadLine.font = UIFont.systemFont(ofSize: Constants.fontSize)
        lblHeadLine.numberOfLines = 0
        return lblHeadLine
    }()
    
    private lazy var lblSubline : UILabel = {
        let lblSubline = UILabel()
        lblSubline.textColor = UIColor.black
        lblSubline.font = UIFont.systemFont(ofSize: Constants.fontSize)
        return lblSubline
    }()
    
    private lazy var statsView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lblHeadLine, lblSubline])
        stackView.axis  = .vertical
        stackView.distribution  = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = Constants.padding
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(rightSideView)
        self.containerView.addSubview(imageDiscount)
        self.containerView.addSubview(lblTitle)
        self.rightSideView.addSubview(lblRightSideView)
        self.containerView.addSubview(statsView)
        [containerView,
         rightSideView,
         lblRightSideView,
         imageDiscount,
         lblTitle,
         lblHeadLine,
         lblSubline,
         statsView]
            .forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
        self.setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupParametrs(items : CitySearchResponse) {
        self.lblTitle.text = items.name
        self.lblRightSideView.text = items.iataCode ?? "N/A"
        self.lblHeadLine.text = items.address?.countryCode
        self.lblSubline.text = items.address?.stateCode
    }
}

extension MainTableViewCell {
    private func setupAutoLayout() {
        
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        
        rightSideView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        rightSideView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        rightSideView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        rightSideView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        lblRightSideView.centerXAnchor.constraint(equalTo: rightSideView.centerXAnchor).isActive = true
        lblRightSideView.centerYAnchor.constraint(equalTo: rightSideView.centerYAnchor).isActive = true
        lblRightSideView.rightAnchor.constraint(greaterThanOrEqualTo: rightSideView.rightAnchor, constant: -5).isActive = true
        lblRightSideView.leftAnchor.constraint(greaterThanOrEqualTo: rightSideView.leftAnchor, constant: 5).isActive = true
        
        imageDiscount.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        imageDiscount.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        imageDiscount.widthAnchor.constraint(equalToConstant: 18).isActive = true
        imageDiscount.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        lblTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        lblTitle.leftAnchor.constraint(equalTo: imageDiscount.rightAnchor, constant: 10).isActive = true
        lblTitle.rightAnchor.constraint(equalTo: rightSideView.leftAnchor, constant: -5).isActive = true
        
        statsView.topAnchor.constraint(equalTo: imageDiscount.bottomAnchor, constant: 10).isActive = true
        statsView.rightAnchor.constraint(equalTo: rightSideView.leftAnchor, constant: -10).isActive = true
        statsView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        statsView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
    }
}
