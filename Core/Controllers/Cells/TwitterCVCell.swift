//
//  TwitterCVCell.swift
//  SmartDashboard
//
//  Created by Benjamin Budet on 12/28/18.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

protocol TwitterCVCellDelegate {
    func didSelect(query: String)
}

class TwitterCVCell: UICollectionViewCell {
    
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var twitterTableView: UITableView!
    
    var arr = [Tweet]()
    
    var delegate: TwitterCVCellDelegate?
    
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
        if let nbr = arr[indexPath.row].tweet_volume {
            cell.tweetNumber.text = "\(nbr) Tweets"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(query: arr[indexPath.row].query ?? "")
    }
}

class TwitterCell: UITableViewCell {
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var tweetNumber: UILabel!
}
