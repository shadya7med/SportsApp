//
//  SportsCollectionViewCell.swift
//  SportsApp
//
//  Created by Shady Ahmed on 2/25/21.
//  Copyright © 2021 Shady Ahmed. All rights reserved.
//

import UIKit

class SportsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sportThumbIV: UIImageView!
    @IBOutlet weak var sportNameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/8
        layer.masksToBounds = true
        
    }
    
    
}
