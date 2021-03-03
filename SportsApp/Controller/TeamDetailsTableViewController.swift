//
//  TeamDetailsTableViewController.swift
//  SportsApp
//
//  Created by Said Elsoudany on 3/3/21.
//  Copyright © 2021 Shady Ahmed. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class TeamDetailsTableViewController: UITableViewController {
    var gradientLayer = CAGradientLayer()
    var id = "133602"
    let teamStr = "https://www.thesportsdb.com/api/v1/json/1/lookupteam.php?id="
    
    @IBOutlet weak var teamName: UIImageView!
    
    @IBOutlet weak var teamLogo: UIImageView!
    
    @IBOutlet weak var teamJersy: UIImageView!
    
    @IBOutlet weak var teamStadium: UIImageView!
    @IBOutlet weak var teamStadiumName: UILabel!
    @IBAction func backPressed(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
      }
    override func viewDidLoad() {
        super.viewDidLoad()
        AF.request(teamStr + id).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let teamsData = json["teams"].arrayValue
                let teamData = teamsData[0].dictionaryValue
                self.teamName.sd_setImage(with: URL(string:teamData["strTeamLogo"]!.stringValue), placeholderImage: UIImage(named: "placeholder"))
                self.teamLogo.sd_setImage(with: URL(string:teamData["strTeamBadge"]!.stringValue), placeholderImage: UIImage(named: "placeholder"))
                self.teamJersy.sd_setImage(with: URL(string:teamData["strTeamJersey"]!.stringValue), placeholderImage: UIImage(named: "placeholder"))
                self.teamStadium.sd_setImage(with: URL(string:teamData["strStadiumThumb"]!.stringValue), placeholderImage:
                    UIImage(named: "placeholder"))
                self.teamStadiumName.text = teamData["strStadium"]!.stringValue
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0)
        {
            return tableView.frame.height/13
        }else if(indexPath.row == 1)
        {
            return tableView.frame.height/7
        }
        else{
            return tableView.frame.height/2.5
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0)
        {
            return tableView.frame.height/13
        }else if(indexPath.row == 1)
        {
            return tableView.frame.height/7
        }
        else{
            return tableView.frame.height/2.5
        }
    }
    
  
    override func viewDidLayoutSubviews() {
        if gradientLayer.superlayer != nil {
            gradientLayer.removeFromSuperlayer()
        }
        let topColor = UIColor(red: 16.0/255.0, green: 12.0/255.0, blue: 54.0/255.0, alpha: 1.0)
        let bottomColor = UIColor(red: 57.0/255.0, green: 33.0/255.0, blue: 61.0/255.0, alpha: 1.0)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableView.bounds.height*2)
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableView.bounds.height*2))
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        tableView.backgroundView = backgroundView
    }
    
}

