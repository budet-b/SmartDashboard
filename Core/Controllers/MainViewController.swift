//
//  ViewController.swift
//  Board
//
//  Created by Benjamin Budet on 12/3/18.
//  Copyright © 2018 EpiMac. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayInfoLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempInfoLabel: UILabel!
    @IBOutlet weak var minmaxLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    let dateFormatter = DateFormatter()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        locationManager.delegate = self
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
        MainBusiness.getWeather(woeid: woeidInt, date: "") { (response, error) in
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
