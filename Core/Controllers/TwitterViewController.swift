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
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let boldAttribute = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 46.0, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
        let regularAttribute = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 46.0, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
        MainBusiness.getSearchTweet(query: query) { (response, error) in
            if error == nil {
                self.statuses = response?.statuses ?? []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                let query = (response?.search_metadata?.query ?? "").replacingOccurrences(of: "%23", with: "#")
                let queryAttributed = NSMutableAttributedString(string: "Tweets for: ", attributes: boldAttribute)
                queryAttributed.append(NSAttributedString(string: query, attributes: regularAttribute))
                self.queryLabel.attributedText = queryAttributed
                self.countLabel.text = "\(response?.search_metadata?.count ?? 0)" + " tweets"
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
    
    override func awakeFromNib() {
        twitterImageView.layer.masksToBounds = true
        twitterImageView.layer.cornerRadius = twitterImageView.bounds.size.height / 2
    }
    
    func configureCell(status: TwitterStatus) {
        twitterLabel.text = status.text
        twitterInfoLabel.attributedText = setup(info: status.user, date: status.created_at)
        let url = URL(string: parseImageURL(status.user?.profile_image_url))
        if let url = url {
            twitterImageView.af_setImage(withURL: url)
        }
        twitterReactionsLabel.text = setup(retweet_count: status.retweet_count, favorite_count: status.favorite_count)
    }
    
    func parseImageURL(_ profile_image_url: String?) -> String {
        if let urlStr = profile_image_url {
            return urlStr.replacingOccurrences(of: "_normal", with: "")
        }
        return ""
    }
    
    
    func setup(info user: TwitterUser?, date: String?) -> NSMutableAttributedString {
        let boldAttribute = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 34.0, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
        let regularAttribute = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 34.0, weight: .regular),
            NSAttributedString.Key.foregroundColor:  UIColor.gray
        ]
        
        let info = NSMutableAttributedString()
        var nameTmp = NSMutableAttributedString()
        if let user = user {
            nameTmp = NSMutableAttributedString(string: user.name ?? "", attributes: boldAttribute)
            if user.verified != nil {
                nameTmp.append(NSAttributedString(string: " ✅ ", attributes: boldAttribute))
            }
            nameTmp.append(NSAttributedString(string: " @" + (user.screen_name ?? ""), attributes: regularAttribute))
        }
        info.append(nameTmp)
        info.append(NSAttributedString(string: " ∙ " + (date?.toTwitterDateString() ?? ""), attributes: regularAttribute))
        return info
    }
    
    func setup(retweet_count: Int?, favorite_count: Int?) -> String {
        var reactions = ""
        if let retweet_count = retweet_count {
            reactions += "🔁 \(retweet_count)"
        }
        if let favorite_count = favorite_count {
            reactions += "❤️ \(favorite_count)"
        }
        return reactions
    }
}
