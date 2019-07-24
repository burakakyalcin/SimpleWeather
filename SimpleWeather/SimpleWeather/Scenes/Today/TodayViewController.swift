//
//  TodayViewController.swift
//  SimpleWeather
//
//  Created by Burak Akyalcin on 24.07.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit
import CoreLocation
import SVProgressHUD

class TodayViewController: UIViewController {

    // MARK: - UI Fields
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Properties
    let locationManager = CLLocationManager()
    var tableViewAdapter: TodayTableViewAdapterProtocol!
    var viewModel: TodayViewModelProtocol!
    
    //MARK: - View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = TodayViewModel()
        viewModel.delegate = self
        
        tableViewAdapter = TodayTableViewAdapter(tableView: tableView)
        tableViewAdapter.delegate = self
        
        //Hide tableview until response from server.
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
            AlertManager.showAlert(in: self, title: "Error", message: "You have to allow location services from settings.")
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
    
    //Get user location coordinates and post these variables to get weather data from service.
    func getUserLocation() {
        if let latitude = locationManager.location?.coordinate.latitude, let longitude = locationManager.location?.coordinate.longitude {
            viewModel.latitude = latitude
            viewModel.longitude = longitude
            
            viewModel.getDailyWeather()
        } else {
            SVProgressHUD.dismiss {
                AlertManager.showAlert(in: self, title: "Error", message: "Cannot get current location.")
            }
        }
    }
    
}

//MARK: - ViewModel delegate methods
extension TodayViewController: TodayViewModelDelegate {
    func onGetDailyWeatherSucceeded() {
        SVProgressHUD.dismiss { [weak self] in
            //Reload tableview when weather info is fetched.
            self?.tableViewAdapter.reloadData(dailyWeather: self?.viewModel.dailyWeather)
            self?.tableView.isHidden = false
        }
        
        //Send data to Firestore DB when weather info is fetched.
        //FirestoreService.sendWeatherDataToFirebase(data: viewModel.dailyWeather)
    }
    
    func onGetDailyWeatherFailed() {
        SVProgressHUD.dismiss {
            AlertManager.showAlert(in: self, title: "Error", message: "Cannot fetch daily weather info.")
        }
    }
}

//MARK: - CLLocationManager Delegate methods
extension TodayViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        getUserLocation()
    }
}

//MARK: - TableViewAdapter Delegate methods
extension TodayViewController: TodayTableViewAdapterDelegate {
    
    //Share location and temperature info.
    func onShareTapped() {
        guard let temp = viewModel.dailyWeather?.main?.temp else { return }
        guard let location = viewModel.dailyWeather?.name else { return }
        let shareContent = "\(location) is \(temp - 273.15)°C today."
        let activityController = UIActivityViewController(activityItems: [shareContent], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
}
