//
//  RecentEventCell.swift
//  SportsApp
//
//  Created by Said Elsoudany on 2/26/21.
//  Copyright © 2021 Shady Ahmed. All rights reserved.
//

import UIKit

class RecentEventCell: UICollectionViewCell {
    
    
    @IBOutlet weak var awayImageCell: RoundImageView!
    @IBOutlet weak var homeImageCell: RoundImageView!
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!

    @IBOutlet weak var awayScore: UILabel!
    @IBOutlet weak var homeScore: UILabel!
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/4
        layer.masksToBounds = true
        
    }
}
