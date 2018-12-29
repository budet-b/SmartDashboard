//
//  ContainerCVCell.swift
//  SmartDashboard
//
//  Created by Benjamin Budet on 12/27/18.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class ContainerCVCell: UICollectionViewCell {
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testButton: UIButton!
    
    func configure(text: String) {
        testLabel.text = text
        testButton.setTitle(text, for: .normal)
    }
}
