//
//  RoundCollectionView.swift
//  SportsApp
//
//  Created by Said Elsoudany on 2/26/21.
//  Copyright © 2021 Shady Ahmed. All rights reserved.
//

import UIKit

class RoundCollectionView: UICollectionView {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/8
        layer.masksToBounds = true
        
        
    }
}
