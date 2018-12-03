//
//  ViewController.swift
//  Board
//
//  Created by Benjamin Budet on 12/3/18.
//  Copyright © 2018 EpiMac. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayInfoLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempInfoLabel: UILabel!
    @IBOutlet weak var minmaxLabel: UILabel!
    
    let dateFormatter = DateFormatter()
    let locationManager = CLLocationManager()
    
    /**
     * TODO:
     * - Round values
     * - Icon weather
     * - Better show labels
     * - Call location 1 time
     * - Save woeid
     * - Call location every 3h
     * - Title in fr
     */

    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        let lattlong = "\(locValue.latitude),\(locValue.longitude)"
        
        MainBusiness.getSearchWeather(lattlong: lattlong) { (response, error) in
            if error == nil {
                if let woeid = response?.first?.woeid {
                    print(response?.first?.title)
                    MainBusiness.getWeather(woeid: woeid, date: "") { (response, error) in
                        if error == nil {
                            if let weather = response?.first {
                                self.tempLabel.text = "\(weather.the_temp ?? 0.0)"
                                self.minmaxLabel.text = "Min: \(weather.min_temp ?? 0.0) / Max: \(weather.max_temp ?? 0.0)"
                                self.tempInfoLabel.text = weather.weather_state_name
                                
                            }
                        }
                    }
                }
            }
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            print("location:: (location)")
        }
    }
    
    @objc func updateLabel() -> Void {
        dateFormatter.dateFormat = "HH:mm"
        hourLabel.text = dateFormatter.string(from: Date())
        dateFormatter.dateFormat = "EEEE"
        dayLabel.text = dateFormatter.string(from: Date()).capitalized
        dateFormatter.dateFormat = "d MMMM yyyy"
        dayInfoLabel.text = dateFormatter.string(from: Date())
    }

}

