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
        view.backgroundColor = #colorLiteral(red: 0.1403488219, green: 0.1641628742, blue: 0.1974385381, alpha: 1)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var lblName : UILabel = {
        let lblTop = UILabel()
        lblTop.textColor = UIColor.white
        lblTop.font = UIFont.boldSystemFont(ofSize: 17)
        lblTop.translatesAutoresizingMaskIntoConstraints = false
        return lblTop
    }()
    
    private lazy var lblFamilyName : UILabel = {
        let lblTop = UILabel()
        lblTop.textColor = UIColor.white
        lblTop.font = UIFont.boldSystemFont(ofSize: 17)
        lblTop.translatesAutoresizingMaskIntoConstraints = false
        return lblTop
    }()
    
    private lazy var statsView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lblName, lblFamilyName])
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
    
    func setupParametrs(items : DataResponse) {
        self.lblName.text = items.destination
        self.lblFamilyName.text = items.departureDate
    }
}

extension MainTableViewCell {
    private func setupAutoLayout() {
        
        containerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true

        statsView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        statsView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20).isActive = true
    
    }
}
