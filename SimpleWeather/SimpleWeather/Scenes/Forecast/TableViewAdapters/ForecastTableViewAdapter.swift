//
//  ForecastTableViewAdapter.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit

//MARK: - ForecastTableViewAdapter protocol method prototypes
protocol ForecastTableViewAdapterProtocol: class {
    func reloadData(days: [Date], dictionary: [Date: [ForecastItem]])
}

//MARK: - ForecastTableViewAdapter
class ForecastTableViewAdapter: NSObject, ForecastTableViewAdapterProtocol {
    let tableView: UITableView!
    
    var dictionary = [Date: [ForecastItem]]()
    var days = [Date]()

    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.registerNibs()
    }
    
    func registerNibs() {
        ForecastTableViewCell.registerSelf(tableView)
    }

    
    func reloadData(days: [Date], dictionary: [Date: [ForecastItem]]) {
        self.days = days
        self.dictionary = dictionary
        tableView.reloadData()
    }
}

//MARK: - UITableView Data Source and Delegate methods
extension ForecastTableViewAdapter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = days[section]
        let arr = dictionary[date]
        return arr?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.className, for: indexPath) as? ForecastTableViewCell else { fatalError("Couldn't dequeue cell with identifier 'ForecastTableViewCell'")}
        let date = days[indexPath.section]
        guard let arr = dictionary[date] else { return cell }
        cell.setCell(with: arr[indexPath.row])
        return cell
    }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UINib(nibName: ForecastHeaderTableViewCell.className, bundle: nil).instantiate(withOwner: nil, options: [:]).first as! ForecastHeaderTableViewCell
        header.setCell(with: days[section])
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}











