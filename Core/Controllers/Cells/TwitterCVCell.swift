//
//  TwitterCVCell.swift
//  SmartDashboard
//
//  Created by Benjamin Budet on 12/28/18.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class TwitterCVCell: UICollectionViewCell {
    
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var twitterTableView: UITableView!
    
    var arr = [Tweet]()
    
    override func awakeFromNib() {
        twitterTableView.delegate = self
        twitterTableView.dataSource = self
        MainBusiness.getTopTweetsFrance { (response, error) in
            if error == nil {
                self.arr = response?.trends ?? []
                DispatchQueue.main.async {
                    self.twitterTableView.reloadData()
                }
            }
            
        }
    }
}

extension TwitterCVCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwitterCell", for: indexPath) as! TwitterCell
        cell.tweetLabel.text = arr[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TwitterCell
        if (cell.tweetLabel.text == arr[indexPath.row].name) {
            cell.tweetLabel.text = "\(arr[indexPath.row].tweet_volume ?? 0) tweets à ce propos"
        } else {
             cell.tweetLabel.text = arr[indexPath.row].name
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class TwitterCell: UITableViewCell {
    @IBOutlet weak var tweetLabel: UILabel!
}
