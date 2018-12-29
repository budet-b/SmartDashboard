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
    
    let arr = ["Hello", "How", "Are", "You"]
    
    override func awakeFromNib() {
        twitterTableView.delegate = self
        twitterTableView.dataSource = self
    }
    
    func configure() {
        //DO CALL
    }
}

extension TwitterCVCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwitterCell", for: indexPath) as! TwitterCell
        cell.tweetLabel.text = arr[indexPath.row]
        return cell
    }
}

class TwitterCell: UITableViewCell {
    @IBOutlet weak var tweetLabel: UILabel!
}
