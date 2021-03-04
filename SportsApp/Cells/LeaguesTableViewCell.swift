//
//  LeaguesTableViewCell.swift
//  SportsApp
//
//  Created by Shady Ahmed on 2/26/21.
//  Copyright © 2021 Shady Ahmed. All rights reserved.
//

import UIKit
protocol LeagueVideoButtonDelegate {
    func cellButtonTapped(link:String)
}

class LeaguesTableViewCell: UITableViewCell {

    var linkDelegate:LeagueVideoButtonDelegate?
    var link:String?
    
    let gradientLayer = CAGradientLayer()
    
    @IBOutlet weak var leagueBadgeIV: UIImageView!
    
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    @IBOutlet weak var leagueVideoBtn: UIButton!
    
    @IBAction func linkButtonAction(_ sender: Any) {
        linkDelegate?.cellButtonTapped(link: link!)
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    

}
