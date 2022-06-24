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
//        view.addshadow(top: true, left: true, bottom: true, right: true, shadowRadius: 1)
        return view
    }()
    
    private lazy var lblHeadLine : UILabel = {
        let lblHeadLine = UILabel()
        lblHeadLine.textColor = UIColor.white
        lblHeadLine.font = UIFont.boldSystemFont(ofSize: 17)
        lblHeadLine.translatesAutoresizingMaskIntoConstraints = false
        return lblHeadLine
    }()
    
    private lazy var lblSubline : UILabel = {
        let lblSubline = UILabel()
        lblSubline.textColor = UIColor.white
        lblSubline.font = UIFont.boldSystemFont(ofSize: 17)
        lblSubline.translatesAutoresizingMaskIntoConstraints = false
        return lblSubline
    }()
    
    private lazy var statsView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lblHeadLine, lblSubline])
        stackView.axis  = .vertical
        stackView.distribution  = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(statsView)
        self.setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupParametrs(items : HotelSearchResponse) {
        self.lblHeadLine.text = items.type?.rawValue
        self.lblSubline.text = items.hotel?.type
    }
}

extension MainTableViewCell {
    private func setupAutoLayout() {
        
        containerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
//        containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true

        statsView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        statsView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20).isActive = true
    
    }
}
