//
//  NewsViewController.swift
//  SmartDashboard
//
//  Created by Benjamin Budet on 12/30/18.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit
import AlamofireImage

class NewsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var infoLabel: UILabel!
    
    var article: Article? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let article = article {
            titleLabel.text = article.title
            let url = URL(string: article.urlToImage ?? "")
            if let url = url {
                backgroundImageView.af_setImage(withURL: url)
                
                let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = view.bounds
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                backgroundImageView.addSubview(blurEffectView)
                
                imageView.af_setImage(withURL: url)
            }
            textView.text = article.content
            infoLabel.text = setupInfo()
        }
    }
    
    func setupInfo() -> String {
        var info = ""
        if let author = article?.author {
            info += author + " | "
        }
        info += article?.publishedAt?.toNewsDateString() ?? ""
        return info
    }
}
