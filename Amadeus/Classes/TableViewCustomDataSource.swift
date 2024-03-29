//
//  MainViewDataSource.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 4/16/22.
//

import UIKit
import Combine

final class TableViewCustomDataSource<Model>: NSObject,UITableViewDataSource {
    
    typealias CellConfigurator = (Model,UITableViewCell)-> Void
    
    var models:[Model]
    var navigateSubject = PassthroughSubject<MainViewController.Event, Never>()
    private let reuseIdentifier:String
    private let cellConfigurator: CellConfigurator
    
    init(models:[Model],reuseIdentifier:String,cellConfigurator:@escaping CellConfigurator) {
        
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cellConfigurator(model,cell)
        return cell
    }    
}

extension TableViewCustomDataSource where Model == HotelSearchResponse {
    static func displayData(for itemLists:[HotelSearchResponse],withCellidentifier reuseIdentifier: String)-> TableViewCustomDataSource {
        return TableViewCustomDataSource(models: itemLists, reuseIdentifier: reuseIdentifier, cellConfigurator: { (data, cell ) in
            let itemcell:MainTableViewCell = cell as! MainTableViewCell
            itemcell.setupParametrs(items: data)
        })
    }
}
