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

    @IBOutlet weak var homeTeamName: UILabel!
    
    @IBOutlet weak var awayTeamName: UILabel!
    
    @IBOutlet weak var timeField: UILabel!
    @IBOutlet weak var dateField: UILabel!
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/8
        layer.masksToBounds = true
        
    }
}
