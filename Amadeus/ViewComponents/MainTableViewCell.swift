//
//  MainTableViewCell.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 1/16/22.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    private lazy var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.dropShadow()
        view.roundCorners([.topLeft, .bottomLeft], radius: 10)
        return view
    }()
    
    private lazy var rightSideView : UIView = {
        let view = UIView()
        view.backgroundColor = .blueBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var lblRightSideView : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageDiscount : UIImageView = {
        let imageMain = UIImageView()
        imageMain.contentMode = .scaleAspectFill
        imageMain.image = UIImage(named: "discount")
        imageMain.translatesAutoresizingMaskIntoConstraints = false
        return imageMain
    }()
    
    private lazy var lblTitle : UILabel = {
        let lblTitle = UILabel()
        lblTitle.textColor = UIColor.black
        lblTitle.font = UIFont.systemFont(ofSize: 15)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        return lblTitle
    }()
    
    private lazy var lblHeadLine : UILabel = {
        let lblHeadLine = UILabel()
        lblHeadLine.textColor = UIColor.black
        lblHeadLine.font = UIFont.systemFont(ofSize: 15)
        lblHeadLine.numberOfLines = 0
        lblHeadLine.translatesAutoresizingMaskIntoConstraints = false
        return lblHeadLine
    }()
    
    private lazy var lblSubline : UILabel = {
        let lblSubline = UILabel()
        lblSubline.textColor = UIColor.black
        lblSubline.font = UIFont.systemFont(ofSize: 15)
        lblSubline.translatesAutoresizingMaskIntoConstraints = false
        return lblSubline
    }()
    
    private lazy var statsView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lblHeadLine, lblSubline])
        stackView.axis  = .vertical
        stackView.distribution  = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
        self.setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupParametrs(items : HotelSearchResponse) {
        self.lblTitle.text = items.hotel?.type
        self.lblRightSideView.text = items.availableText()
        self.lblHeadLine.text = items.hotel?.name
        self.lblSubline.text = items.hotel?.hotelID
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
