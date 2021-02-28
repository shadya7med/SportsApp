//
//  Team.swift
//  SportsApp
//
//  Created by Said Elsoudany on 2/27/21.
//  Copyright © 2021 Shady Ahmed. All rights reserved.
//

import UIKit

class Team: NSObject {
    var teamId : String?
    var teamName : String?
    var teamShortName : String?
    var teamBadge : String?
    init(name : String, badge : String , id : String) {
        self.teamName = name
        self.teamShortName = String((teamName?.prefix(3))!).uppercased()
        self.teamBadge = badge
        self.teamId = id
        
    }
}
