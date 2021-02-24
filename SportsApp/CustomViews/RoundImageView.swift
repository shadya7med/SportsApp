//
//  RoundImageView.swift
//  SportsApp
//
//  Created by Said Elsoudany on 2/24/21.
//  Copyright © 2021 Shady Ahmed. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {


    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/2
        layer.masksToBounds = true
        layer.borderWidth = 1
        
    }
}

