//
//  TodayTableViewAdapter.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit

//MARK: - TodayTableViewAdapter Protocol method protocols and properties
protocol TodayTableViewAdapterProtocol: class {
    var dailyWeather: DailyWeather? { get set }
    var delegate: TodayTableViewAdapterDelegate? { get set }
    func reloadData(dailyWeather: DailyWeather?)
}

//MARK: - TodayTableViewAdapter Delegate method prototypes
protocol TodayTableViewAdapterDelegate: class {
    func onShareTapped()
}

//MARK: - TodayTableViewAdapter
class TodayTableViewAdapter: NSObject, TodayTableViewAdapterProtocol {
    
    weak var delegate: TodayTableViewAdapterDelegate?
    
    let tableView: UITableView!
    
    var dailyWeather: DailyWeather?
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.registerNibs()
    }
    
    func registerNibs() {
        WeatherHeaderTableViewCell.registerSelf(tableView)
        WeatherDetailsTableViewCell.registerSelf(tableView)
        WeatherDetailFooterTableViewCell.registerSelf(tableView)
    }
    
    func reloadData(dailyWeather: DailyWeather?) {
        self.dailyWeather = dailyWeather
        tableView.reloadData()
    }
}


//MARK: - UITableView Data Source and Delegate methods
extension TodayTableViewAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return cellForHeader(tableView: tableView, indexPath: indexPath)
        case 1:
            return cellForDetail(tableView: tableView, indexPath: indexPath)
        case 2:
            return cellForFooter(tableView: tableView, indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    
    func cellForHeader(tableView: UITableView, indexPath: IndexPath) -> WeatherHeaderTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherHeaderTableViewCell.className, for: indexPath) as? WeatherHeaderTableViewCell else { fatalError("Couldn't dequeue cell with identifier 'WeatherHeaderTableViewCell'")}
        guard let model = dailyWeather else { return cell }
        cell.setCell(with: model)
        return cell
    }
    
    func cellForDetail(tableView: UITableView, indexPath: IndexPath) -> WeatherDetailsTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailsTableViewCell.className, for: indexPath) as? WeatherDetailsTableViewCell else { fatalError("Couldn't dequeue cell with identifier 'WeatherDetailsTableViewCell'")}
        guard let model = dailyWeather else { return cell }
        cell.setCell(with: model)
        return cell
    }
    
    //TODO: Change Name of class maybe?
    func cellForFooter(tableView: UITableView, indexPath: IndexPath) -> WeatherDetailFooterTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailFooterTableViewCell.className, for: indexPath) as? WeatherDetailFooterTableViewCell else { fatalError("Couldn't dequeue cell with identifier 'WeatherDetailFooterTableViewCell'")}
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - WeatherDetailFooterTableViewCell Delegate methods.
extension TodayTableViewAdapter: WeatherDetailFooterTableViewCellDelegate {
    func onShareTapped() {
        delegate?.onShareTapped()
    }
}








