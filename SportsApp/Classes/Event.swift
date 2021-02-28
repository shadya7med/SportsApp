//
//  Event.swift
//  SportsApp
//
//  Created by Said Elsoudany on 2/27/21.
//  Copyright © 2021 Shady Ahmed. All rights reserved.
//

import UIKit

class Event: NSObject {
    var eventId : String?
    var homeTeamId : String?
    var awayTeamId : String?
    var eventDate : String?
    var eventTime : String?
    var homeScore : String?
    var awayScore : String?
    init(eventId : String , homeTeamId : String, awayTeamId : String, date : String, time : String, homeScore : String, awayScore : String) {
        self.eventId = eventId
        self.homeTeamId = homeTeamId
        self.awayTeamId = awayTeamId
        self.eventDate = date
        self.eventTime = time
        self.homeScore = homeScore
        self.awayScore = awayScore
    }
    

}
