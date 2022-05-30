//
//  MainViewController.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 9/12/21.
//

import UIKit
import Combine
import Alamofire
import SwiftUI
 
class MainViewController: BaseViewController {

    let cellId = "cellId"
    var viewModel : MainViewModel?
    var navigateSubject = PassthroughSubject<MainViewController.Event, Never>()
    var contentView : MainView?
    private(set) var data : FlightSearchResponse?
    private var dataSource:TableViewCustomDataSource<DataResponse>?

        
    init(viewModel : MainViewModel, contentView : MainView) {
        self.viewModel = viewModel
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        super.delegate = self
        self.setupTableView()
        self.bindViewModel()
        self.callFlightServie()
        contentView?.viewContainer.emptyState.delegate = self
        self.setupNavigationBar()
    }
        
    private func setupTableView() {
        contentView?.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    private func setupNavigationBar() {
        self.setDefaultAppearanceNavigationBar(with: .white)
        self.navigationItem.title = "Amadeus"
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
    }
        
    private func bindViewModel() {
        self.viewModel?.loadinState
            .sink(receiveValue: {  state in
                guard let view = self.contentView else {return}
                super.setViewState(state: state, viewContainer: view.viewContainer)
            }).store(in: &bag)

        self.viewModel?.$flightData
            .compactMap({ $0 })
            .sink { [weak self] data in
                self?.data = data
                guard let data = data.data else {return}
                self?.renderTableViewdataSource(data)
            }.store(in: &bag)
    }
    
    private func renderTableViewdataSource(_ itemlists:[DataResponse]) {
        dataSource = .displayData(for: itemlists, withCellidentifier: cellId)
        self.contentView?.tableView.dataSource = dataSource
        self.contentView?.tableView.delegate = self
        self.contentView?.tableView.reloadData()
    }
    
    private func callFlightServie() {
        self.viewModel?.getFlightInspirationData(origin: "MAD")
    }
}

extension MainViewController : EmptyStateDelegate, ShowEmptyStateProtocol {
    func showEmptyStateView(title: String?, errorType: EmptyStateErrorType, isShow: Bool) {
        contentView?.viewContainer.emptyState.show(title: title ?? "", errorType: errorType, isShow: isShow)
    }
    
    func emptyStateButtonClicked() {
        self.callFlightServie()
        contentView?.viewContainer.emptyState.hide()
    }
}

extension MainViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rawData = self.data, let data = rawData.data?[indexPath.row] else {return}
        self.navigateSubject.send(.detail(data: data))
    }
}

extension MainViewController {
    enum Event {
        case main
        case detail(data : DataResponse)
    }
}

