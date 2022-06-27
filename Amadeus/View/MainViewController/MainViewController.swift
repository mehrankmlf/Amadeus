//
//  MainViewController.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 9/12/21.
//

import UIKit
import Combine
 
class MainViewController: BaseViewController {

    var viewModel : MainViewModel!
    var navigateSubject = PassthroughSubject<MainViewController.Event, Never>()
    var contentView : MainView?
    private(set) var data : [HotelSearchResponse]?
    private var dataSource:TableViewCustomDataSource<HotelSearchResponse>?

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
        self.callServie()
        contentView?.viewContainer.emptyState.delegate = self
        self.setupNavigationBar()
    }
        
    private func setupTableView() {
        contentView?.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainViewModel.cellId)
    }
    
    private func setupNavigationBar() {
        self.setDefaultAppearanceNavigationBar(with: .white)
        self.navigationItem.title = viewModel?.title
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
    }
        
    private func bindViewModel() {
        self.viewModel?.loadinState
            .sink(receiveValue: {  state in
                guard let view = self.contentView else {return}
                super.setViewState(state: state, viewContainer: view.viewContainer)
            }).store(in: &bag)

        self.viewModel?.$hotelData
            .compactMap({ $0 })
            .sink { [weak self] data in
                self?.data = data
                self?.renderTableViewdataSource(data)
            }.store(in: &bag)
    }
    
    private func renderTableViewdataSource(_ itemlists:[HotelSearchResponse]) {
        dataSource = .displayData(for: itemlists, withCellidentifier: MainViewModel.cellId)
        self.contentView?.tableView.dataSource = dataSource
        self.contentView?.tableView.delegate = self
        self.contentView?.tableView.reloadData()
    }
    
    private func callServie() {
        self.viewModel?.getHotelsData(cityCode: "PAR")
    }
}

extension MainViewController : EmptyStateDelegate, ShowEmptyStateProtocol {
    func showEmptyStateView(title: String?, errorType: EmptyStateErrorType, isShow: Bool) {
        contentView?.viewContainer.emptyState.show(title: title ?? "", errorType: errorType, isShow: isShow)
    }
    
    func emptyStateButtonClicked() {
        self.callServie()
        contentView?.viewContainer.emptyState.hide()
    }
}

extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rawData = self.data else {return}
        let data = rawData[indexPath.row]
        self.navigateSubject.send(.detail(data: data))
    }
}

extension MainViewController {
    enum Event {
        case main
        case detail(data : HotelSearchResponse)
    }
}

