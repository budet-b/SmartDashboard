//
//  HomeKitCVCell.swift
//  SmartDashboard
//
//  Created by Benjamin_Budet on 30/12/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit
import HomeKit

class HomeKitCVCell: UICollectionViewCell {
    
    @IBOutlet weak var HomeKitAccessoriesCV: UICollectionView!
    
    let homeManager = HMHomeManager()
    var hmAccessories: [HMAccessory] = []
    var accessorieUi: [String: String] = [:]
    
    override func awakeFromNib() {
        HomeKitAccessoriesCV.delegate = self
        HomeKitAccessoriesCV.dataSource = self
        homeManager.delegate = self
    }
    
    func updateHKAccessories(accessories: [HMAccessory]) {
        print(accessories)
        hmAccessories = accessories
        for accessory in accessories {
            accessory.delegate = self
            updateHomeKitArray(accessory: accessory)
        }
        HomeKitAccessoriesCV.reloadData()
    }
    
    func updateHomeKitArray(accessory: HMAccessory) {
        for service in accessory.services {
            for characteristic in service.characteristics {
                if let metadata = characteristic.metadata?.manufacturerDescription {
                    if metadata == "Power State" {
                        if let value = characteristic.value {
                            if let state = value as? Int {
                                if state == 0 {
                                    accessorieUi[accessory.name] = "Off"
                                    //OFF
                                    break
                                } else if state == 1 {
                                    accessorieUi[accessory.name] = "On"
                                    //ON
                                }
                            }
                            print(value)
                        }
                    }
                    else if metadata == "Brightness" {
                        if let value = characteristic.value {
                            // On récupère ici la valeur de luminosité
                            accessorieUi[accessory.name] = "\(value) %"
                            print(value)
                        }
                    }
                }
            }
        }
    }
}

extension HomeKitCVCell: HMHomeDelegate, HMAccessoryDelegate, HMHomeManagerDelegate {
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        MainBusiness.getAccessories(manager: manager, completed: self.updateHKAccessories)
    }
    
    func accessory(_ accessory: HMAccessory,
                   service: HMService,
                   didUpdateValueFor characteristic: HMCharacteristic) {
        print(accessory.name)
        updateHomeKitArray(accessory: accessory)
        HomeKitAccessoriesCV.reloadData()
    }
}


extension HomeKitCVCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hmAccessories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HMAccessoryCell", for: indexPath) as! HomeKitAccessoriesCell
        cell.HomeKitAccessorieName.text = hmAccessories[indexPath.row].name
        cell.HomeKitAccessorieStatus.text = accessorieUi[hmAccessories[indexPath.row].name]
        return cell
    }
}

class HomeKitAccessoriesCell: UICollectionViewCell {
    @IBOutlet weak var HomeKitAccessorieName: UILabel!
    @IBOutlet weak var HomeKitAccessorieStatus: UILabel!
}
