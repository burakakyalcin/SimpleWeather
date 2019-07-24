//
//  ForecastViewController.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit
import CoreLocation
import SVProgressHUD

class ForecastViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Properties
    let locationManager = CLLocationManager()
    var tableViewAdapter: ForecastTableViewAdapterProtocol!
    var viewModel: ForecastViewModelProtocol!
    
    //MARK: - View Lifecycle methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ForecastViewModel()
        viewModel.delegate = self
        
        tableViewAdapter = ForecastTableViewAdapter(tableView: tableView)
        tableView.isHidden = true
        
        SVProgressHUD.show()
        
        checkLocationServices()
    }
    
    //MARK: - Location Manager helper methods.
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            SVProgressHUD.dismiss {
                AlertManager.showAlert(in: self, title: "Error", message: "You have to allow location services from settings.")
            }
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            getUserLocation()
            break
        case .authorizedWhenInUse:
            getUserLocation()
            break
        case .denied:
            SVProgressHUD.dismiss {
                AlertManager.showAlert(in: self, title: "Error", message: "You have to allow location services from settings.")
            }
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            SVProgressHUD.dismiss {
                AlertManager.showAlert(in: self, title: "Error", message: "You have to allow location services from settings.")
            }
            break
        }
    }
    
    func getUserLocation() {
        if let latitude = locationManager.location?.coordinate.latitude, let longitude = locationManager.location?.coordinate.longitude {
            viewModel.latitude = latitude
            viewModel.longitude = longitude
            
            viewModel.getForecast()
        } else {
            SVProgressHUD.dismiss {
                AlertManager.showAlert(in: self, title: "Error", message: "Cannot get coordinates.")
            }
        }
    }
    
}

//MARK: - ViewModel Delegate methods.
extension ForecastViewController: ForecastViewModelDelegate {
    func onGetForecastSucceeded() {
        SVProgressHUD.dismiss { [weak self] in
            guard let strongSelf = self else { return }
            self?.tableViewAdapter.reloadData(days: strongSelf.viewModel.days, dictionary: strongSelf.viewModel.dictionary)
            self?.titleLabel.text = self?.viewModel.forecast?.city.name
            self?.tableView.isHidden = false
        }
    }
    
    func onGetForecastFailed() {
        SVProgressHUD.dismiss {
            AlertManager.showAlert(in: self, title: "Error", message: "Cannot fetch forecast from service.")
        }
    }
}

//MARK: - CLLocationManager Delegate methods
extension ForecastViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        getUserLocation()
    }
}
