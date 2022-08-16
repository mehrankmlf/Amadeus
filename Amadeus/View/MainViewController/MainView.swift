//
//  MainView.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 5/29/22.
//

import UIKit

final class MainView: UIView {
        
    private var safeArea: UILayoutGuide!
    
    lazy var viewContainer : UIView = {
        let viewContainer = UIView()
        viewContainer.backgroundColor = .whiteBackground
        return viewContainer
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
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
        addSubview(viewContainer)
        viewContainer.addSubview(tableView)
        [viewContainer, tableView]
            .forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setupUI() {
        backgroundColor = .whiteBackground
        safeArea = self.safeAreaLayoutGuide
    }
}

extension MainView {
    private func makeAutolayout() {
        NSLayoutConstraint.activate([
            viewContainer.topAnchor.constraint(equalTo: safeArea.topAnchor),
            viewContainer.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            viewContainer.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
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
