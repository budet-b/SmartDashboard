//
//  TwitterViewController.swift
//  SmartDashboard
//
//  Created by Benjamin Budet on 12/31/18.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit
import AlamofireImage

class TwitterViewController: UIViewController {

    var query: String = ""
    var statuses = [TwitterStatus]()
    
    @IBOutlet weak var queryLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainBusiness.getSearchTweet(query: query) { (response, error) in
            if error == nil {
                self.statuses = response?.statuses ?? []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension TwitterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetsCell", for: indexPath) as! TweetsCell
        cell.configureCell(status: statuses[indexPath.row])
        return cell
    }
}

class TweetsCell: UITableViewCell {
    @IBOutlet weak var twitterImageView: UIImageView!
    @IBOutlet weak var twitterInfoLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var twitterReactionsLabel: UILabel!
    
    func configureCell(status: TwitterStatus) {
        twitterLabel.text = status.text
        if let user = status.user {
            twitterInfoLabel.text = user.name
        }
        let url = URL(string: status.user?.profile_image_url ?? "")
        if let url = url {
            twitterImageView.af_setImage(withURL: url)
        }
        twitterReactionsLabel.text = "\(status.retweet_count ?? 0) RT"
    }
}
