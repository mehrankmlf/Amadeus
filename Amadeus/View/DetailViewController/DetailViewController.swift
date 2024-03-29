//
//  DetailViewController.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 2/17/22.
//

import UIKit

final class DetailViewController: BaseViewController<DetailViewModel> {
    
    var data: HotelSearchResponse?
    let contentView = DetailView()

    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.showData()
    }
    
    private func setupNavigationBar() {
        self.setDefaultAppearanceNavigationBar(with: .white)
        self.navigationItem.title = "Detail"
        self.navigationController?.navigationBar.tintColor = UIColor.gray
    }
    
    private func showData(){
        guard let data = data, let hotel = data.hotel else {return}
        self.contentView.lblHeadLineDetail.text = hotel.hotelID
        self.contentView.lblSublineDetail.text = hotel.name
    }
}


