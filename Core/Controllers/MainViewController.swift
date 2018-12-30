//
//  ViewController.swift
//  Board
//
//  Created by Benjamin Budet on 12/3/18.
//  Copyright © 2018 EpiMac. All rights reserved.
//

import UIKit
import CoreLocation
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
    
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changePriceLabel: UILabel!
    
    let dateFormatter = DateFormatter()
    let locationManager = CLLocationManager()
    
    
    var stocks = [Stocks]()
    
    let collectionTopInset: CGFloat = 0
    let collectionBottomInset: CGFloat = 0
    let collectionLeftInset: CGFloat = 10
    let collectionRightInset: CGFloat = 10
    
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
        getStocks()
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
    
    func getStocks() {
        MainBusiness.getStocks { (response, error) in
            if error == nil {
                self.stocks = response!
                self.updateStocks()
            }
        }
    }
    
    func updateStocks() {
        var count = 0
        self.setupStock(for: count)
        if !stocks.isEmpty {
            Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { (timer) in
                count += 1
                let index = count % self.stocks.count
                self.setupStock(for: index)
            }

        }
    }
    
    func setupStock(for index: Int) {
        let elmt = stocks[index]
        stockLabel.text = elmt.symbol
        companyLabel.text = elmt.companyName
        priceLabel.text = "\(elmt.latestPrice ?? 0.0)"
        var changePrice = ""
        if let extendedChange = elmt.extendedChange {
            if extendedChange < 0.0 {
                changePrice += "🔻"
                changePriceLabel.textColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
            }
            else {
                changePrice += "🔺"
                changePriceLabel.textColor = #colorLiteral(red: 0.2980392157, green: 0.8509803922, blue: 0.3921568627, alpha: 1)
            }
            changePrice += "\(elmt.extendedChange ?? 0.0)"
        }
        changePriceLabel.text = changePrice
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

extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
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
        } else if indexPath.row == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeKitCVCell", for: indexPath) as! HomeKitCVCell
            return cell
        }
            
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContainerCVCell", for: indexPath) as! ContainerCVCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return false
    }
}
