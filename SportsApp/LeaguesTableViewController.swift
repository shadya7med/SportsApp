//
//  LeaguesTableViewController.swift
//  SportsApp
//
//  Created by Shady Ahmed on 2/26/21.
//  Copyright © 2021 Shady Ahmed. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON


class LeaguesTableViewController: UITableViewController,LeagueVideoButtonDelegate {
    var currentSport:String = ""
    
    var leagueIds:Array<String> = []
    var leagues:Array<League> = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentSport)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //get League IDS
        AF.request("https://www.thesportsdb.com/api/v1/json/1/all_leagues.php").responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let leaguesArr = json["leagues"].arrayValue
                for league in leaguesArr {
                    let leagueDic = league.dictionaryValue
                    if leagueDic["strSport"]?.stringValue == self.currentSport
                    {
                        let id = leagueDic["idLeague"]?.stringValue
                        self.leagueIds.append(id!)
                        
                    }else{
                        continue
                    }
                    
                }
                self.tableView.reloadData()
                
                
            
                
            case .failure(let error):
                print(error)
            }
        }
        print(leagueIds.count)
        //get league Details by ID
        
   
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagueIds.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaguesCell", for: indexPath) as! LeaguesTableViewCell
        let temp = self.leagueIds[indexPath.row]
        let leagueUrl = "https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id" + "=" + temp
        let leagueIds = leagues.map { (League) -> String in
            return League.leagueId!
        }
        
        if !leagueIds.contains(temp)
        {
        AF.request(leagueUrl).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let league = json["leagues"].arrayValue
                
                let leagueDic = league[0].dictionaryValue
                let name = leagueDic["strLeague"]?.stringValue
                let badge = leagueDic["strBadge"]?.stringValue
                let link = leagueDic["strYoutube"]?.stringValue
                self.leagues.append(League(leagueId : temp,leagueName: name!, leagueBadge: badge!, leagueLink: link!))
                cell.leagueNameLabel.text = name
                //check if there's a link
                if link != ""
                {
                    cell.link = link
                    cell.linkDelegate = self
                }else{
                    //hide the button if there's no link
                    cell.leagueVideoBtn.isHidden = true
                }
                
                
                
                cell.leagueBadgeIV.sd_setImage(with: URL(string: badge ?? ""),placeholderImage: UIImage(named: "placeholder"))
                
            case .failure(let error):
                print(error)
            }
        }
        }
        else{
            let league = leagues.filter { (League) -> Bool in
                return League.leagueId == temp
            }
            cell.leagueNameLabel.text = league[0].leagueName

            cell.leagueBadgeIV.sd_setImage(with: URL(string: league[0].leagueBadge ?? ""),placeholderImage: UIImage(named: "placeholder"))
            cell.link = league[0].leagueLink
            cell.linkDelegate = self
        }
        
        
        
        // Configure the cell...
    
        return cell
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let svc = self.storyboard?.instantiateViewController(identifier: "SecondVC") as! LeagueTableViewController
        svc.id = leagueIds[indexPath.row]
        svc.modalPresentationStyle = .fullScreen
        present(svc, animated: true, completion: nil)
    }

    
    // MARK:  - cell link Delegate
    func cellButtonTapped(link: String) {
            //check if there's a url
            if(link != nil)
            {
                //open the link in safari instead
                let youtubeUrl = URL(string:"https://\(link)")!
                UIApplication.shared.openURL(youtubeUrl)
            }
            
        
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
