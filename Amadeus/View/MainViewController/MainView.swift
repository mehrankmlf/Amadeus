//
//  MainView.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 5/29/22.
//

import UIKit

final class MainView: UIView {
    
    lazy var viewContainer : UIView = {
        let viewContainer = UIView()
        viewContainer.backgroundColor = .white
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        return viewContainer
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
        addSubview(viewContainer)
        viewContainer.addSubview(tableView)
    }
    
    private func setupUI() {
        backgroundColor = .background
    }
}

extension MainView {
    private func makeAutolayout() {
        NSLayoutConstraint.activate([
            viewContainer.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            viewContainer.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            viewContainer.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.viewContainer.topAnchor),
            tableView.leftAnchor.constraint(equalTo: self.viewContainer.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.viewContainer.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.viewContainer.bottomAnchor)
        ])
    }
}
