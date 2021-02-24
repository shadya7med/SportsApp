//
//  UpComingEventCell.swift
//  SportsApp
//
//  Created by Said Elsoudany on 2/24/21.
//  Copyright © 2021 Shady Ahmed. All rights reserved.
//

import UIKit

class UpComingEventCell: UICollectionViewCell {
    
    @IBOutlet weak var homeTeamImage: RoundImageView!
    
    @IBOutlet weak var awayTeamImage: RoundImageView!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/8
        layer.masksToBounds = true
        layer.borderWidth = 1
    }
}
