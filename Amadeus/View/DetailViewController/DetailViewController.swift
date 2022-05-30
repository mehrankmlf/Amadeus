//
//  DetailViewController.swift
//  SappPlus
//
//  Created by Mehran Kamalifard on 2/17/22.
//

import UIKit

class DetailViewController: BaseViewController {
    
    var  data : DataResponse?
    var contentView : DetailView?
    
    init(data : DataResponse, contentView : DetailView) {
        self.data = data
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
        self.setupNavigationBar()
        self.showData()
    }
    
    private func setupNavigationBar() {
        self.setDefaultAppearanceNavigationBar(with: .white)
        self.navigationItem.title = "Detail"
        self.navigationController?.navigationBar.tintColor = UIColor.gray
    }
    
    private func showData(){
        guard let data = data else {return}
        self.contentView?.lblDestinationDetail.text = data.destination
        self.contentView?.lblDeparturDetail.text = data.departureDate
    }
}


