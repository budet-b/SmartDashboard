//
//  NewsCVCell.swift
//  SmartDashboard
//
//  Created by Alexandre Toubiana on 12/28/18.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit
import AlamofireImage

class NewsCVCell: UICollectionViewCell {
    
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsTableView: UITableView!
    
    var newsArr = [Article]()
    
    override func awakeFromNib() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        MainBusiness.getNews { (response, error) in
            if error == nil {
                self.newsArr = response?.articles ?? []
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
            }
        }
    }
    
//    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
//        if self.isFocused {
//            self.contentView.backgroundColor = .red
//        }
//        else {
//            self.contentView.backgroundColor = .none
//        }
//    }
}


extension NewsCVCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.newsLabel.text = newsArr[indexPath.row].title
        let url = URL(string: newsArr[indexPath.row].urlToImage ?? "")
        if let url = url {
            cell.newsImageView.af_setImage(withURL: url)
        }
        return cell
    }
    
}

class NewsCell: UITableViewCell {
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
}
