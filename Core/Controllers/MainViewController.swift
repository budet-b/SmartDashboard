//
//  ViewController.swift
//  Board
//
//  Created by Benjamin Budet on 12/3/18.
//  Copyright © 2018 EpiMac. All rights reserved.
//

import UIKit
import CoreLocation
import HomeKit
import ExternalAccessory

class MainViewController: UIViewController {

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayInfoLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempInfoLabel: UILabel!
    @IBOutlet weak var minmaxLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let dateFormatter = DateFormatter()
    let locationManager = CLLocationManager()
    
    let homeManager = HMHomeManager()
    var hmAccessories: [HMAccessory] = []
    
    let collectionTopInset: CGFloat = 0
    let collectionBottomInset: CGFloat = 0
    let collectionLeftInset: CGFloat = 10
    let collectionRightInset: CGFloat = 10
    
    @IBOutlet weak var homeKitTableViewAccessories: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        homeKitTableViewAccessories.delegate = self
        homeKitTableViewAccessories.dataSource = self
        locationManager.delegate = self
        homeManager.delegate = self

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        if UserDefaultsUtils.getData(key: UserDefaultsUtils.woeid) != "" {
            getWeather()
        }
    }
    
    @objc func updateTime() -> Void {
        dateFormatter.dateFormat = "HH:mm"
        hourLabel.text = dateFormatter.string(from: Date())
        dateFormatter.dateFormat = "EEEE"
        dayLabel.text = dateFormatter.string(from: Date()).capitalized
        dateFormatter.dateFormat = "d MMMM yyyy"
        dayInfoLabel.text = dateFormatter.string(from: Date())
    }
    
    func getWeather() {
        let woeid = UserDefaultsUtils.getData(key: UserDefaultsUtils.woeid)
        let woeidInt = Int(woeid) ?? 0
        MainBusiness.getWeather(woeid: woeidInt) { (response, error) in
            if error == nil {
                self.setWeatherLabels(response?.first)
            }
        }
    }
    
    func setWeatherLabels(_ weather: Weather?) {
        if let weather = weather {
            self.tempLabel.text = "\(Int(weather.the_temp ?? 0.0))°C"
            self.minmaxLabel.text = "Min: \(Int(weather.min_temp ?? 0.0)) / Max: \(Int(weather.max_temp ?? 0.0))"
            self.tempInfoLabel.text = Constants.weatherStatus[weather.weather_state_abbr ?? ""]
            self.weatherImageView.image = UIImage(named: weather.weather_state_abbr ?? "")
        }
    }

    func updateHKAccessories(accessories: [HMAccessory]) {
        print(accessories)
        hmAccessories = accessories
        for accessory in accessories {
            accessory.delegate = self
        }
        homeKitTableViewAccessories.reloadData()
    }
}

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if UserDefaultsUtils.getData(key: UserDefaultsUtils.woeid) == "" {
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
            let lattlong = "\(locValue.latitude),\(locValue.longitude)"
            
            MainBusiness.getSearchWeather(lattlong: lattlong) { (response, error) in
                if error == nil {
                    if let woeid = response?.first?.woeid {
                        UserDefaultsUtils.saveData(key: UserDefaultsUtils.woeid, value: String(describing: woeid))
                        self.getWeather()
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {}
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hmAccessories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hmaccessory", for: indexPath)
        cell.textLabel?.text = hmAccessories[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension MainViewController: HMHomeDelegate, HMAccessoryDelegate, HMHomeManagerDelegate {
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        MainBusiness.getAccessories(manager: manager, completed: self.updateHKAccessories)
    }
    
    func accessory(_ accessory: HMAccessory,
                   service: HMService,
                   didUpdateValueFor characteristic: HMCharacteristic) {
        print(accessory.name)
    }
}


extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TwitterCVCell", for: indexPath) as! TwitterCVCell
            cell.configure()
            return cell
        }
        else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCVCell", for: indexPath) as! NewsCVCell
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContainerCVCell", for: indexPath) as! ContainerCVCell
            return cell
        }
    }
}
