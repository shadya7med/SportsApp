//
//  LeagueTableViewController.swift
//  SportsApp
//
//  Created by Said Elsoudany on 2/25/21.
//  Copyright © 2021 Shady Ahmed. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

private let upComingEventReuseIdentifier = "Cell"
private let recentEventReuseIdentifier = "Cell2"
private let teamReuseIdentifier = "Cell3"
class LeagueTableViewController: UITableViewController {
    @IBOutlet weak var upComingEventCollController: UICollectionView!
    @IBOutlet weak var recentEventCollController: UICollectionView!
    @IBOutlet weak var teamCollController: UICollectionView!
    var horizontalFlowLayout : UICollectionViewFlowLayout?
    var verticalFlowLayout :UICollectionViewFlowLayout?
    let arrayOfHeaders = ["Upcoming Events","Recent Events","Teams"]
    var id = "4335"
    var teamsArray = Array<Team>()
    var eventsArray = Array<Event>()
    let leagueStr = "https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id="
    let leagueEventStr = "https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        
        
        upComingEventCollController.delegate = self
        upComingEventCollController.dataSource = self
        recentEventCollController.delegate = self
        recentEventCollController.dataSource = self
        teamCollController.delegate = self
        teamCollController.dataSource = self
        
        
        upComingEventCollController.collectionViewLayout.collectionView?.backgroundColor = tableView.backgroundColor
        recentEventCollController.collectionViewLayout.collectionView?.backgroundColor = tableView.backgroundColor
        
        tableView.tableHeaderView?.backgroundColor = tableView.backgroundColor
        
        
        AF.request(leagueStr + id).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let teamArr = json["teams"].arrayValue
                for team in teamArr {
                    let teamDic = team.dictionaryValue
                    let name = teamDic["strTeam"]?.stringValue
                    let badge = teamDic["strTeamBadge"]?.stringValue
                    let id = teamDic["idTeam"]?.stringValue
                    self.teamsArray.append(Team(name: name!, badge: badge!, id: id!))
                }
                self.teamCollController.reloadData()
                self.upcomingEventsRequest()
            case .failure(let error):
                print(error)
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    func upcomingEventsRequest()
    {
        AF.request(leagueEventStr + id).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let eventArr = json["events"].arrayValue
                for event in eventArr {
                    let eventDic = event.dictionaryValue
                    let homeId = eventDic["idHomeTeam"]?.stringValue
                    let awayId = eventDic["idAwayTeam"]?.stringValue
                    let id = eventDic["idEvent"]?.stringValue
                    let date = eventDic["dateEvent"]?.stringValue
                    let time = eventDic["strTime"]?.stringValue
                    let homeScore = eventDic["intHomeScore"]?.stringValue
                    let awayScore = eventDic["intAwayScore"]?.stringValue
                    self.eventsArray.append(Event(eventId: id!, homeTeamId: homeId!, awayTeamId: awayId!, date: date!, time: time!, homeScore: homeScore!, awayScore: awayScore!))
                }
                self.upComingEventCollController.reloadData()
                self.recentEventCollController.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.height/4
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/4
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
        returnedView.backgroundColor = tableView.backgroundColor
        
        let label = UILabel(frame: CGRect(x: 10, y: 7, width: view.frame.size.width, height: 25))
        label.text = arrayOfHeaders[section]
        label.textColor = .white
        
        returnedView.addSubview(label)
        
        return returnedView
    }
    
    
}
extension LeagueTableViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numOfItems = 0;
        
        switch(collectionView.tag){
        case 3 :
            numOfItems = eventsArray.count
        case 4 :
            numOfItems = eventsArray.count
        default :
            numOfItems = teamsArray.count
        }
        return numOfItems;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var teamCell : TeamCell?
        var upComingCell : UpComingEventCell?
        var recentCell : RecentEventCell?
        switch(collectionView.tag){
        case 3 :
            upComingCell = collectionView.dequeueReusableCell(withReuseIdentifier: upComingEventReuseIdentifier, for: indexPath) as? UpComingEventCell
            let event = eventsArray[indexPath.row]
            let homeTeam = teamsArray.filter { (team) -> Bool in
                team.teamId == event.homeTeamId
            }
            let awayTeam = teamsArray.filter { (team) -> Bool in
                team.teamId == event.awayTeamId
            }
            
            upComingCell?.homeTeamImage.sd_setImage(with: URL(string: homeTeam[0].teamBadge!), placeholderImage: UIImage(named: "placeholder"))
            upComingCell?.awayTeamImage.sd_setImage(with: URL(string: awayTeam[0].teamBadge!), placeholderImage: UIImage(named: "placeholder"))
            upComingCell?.homeTeamName.text = homeTeam[0].teamName
            upComingCell?.awayTeamName.text = awayTeam[0].teamName
            upComingCell?.dateField.text = event.eventDate!
            upComingCell?.timeField.text = event.eventTime!
            switch indexPath.row % 2 {
            case 0:
                upComingCell!.backgroundColor = UIColor.systemBlue
            case 1:
                upComingCell!.backgroundColor = UIColor.systemPink
            default:
                break
            }
            return upComingCell!
        case 4 :
            recentCell = collectionView.dequeueReusableCell(withReuseIdentifier: recentEventReuseIdentifier, for: indexPath) as? RecentEventCell
            
            let event = eventsArray[indexPath.row]
            let homeTeam = teamsArray.filter { (team) -> Bool in
                team.teamId == event.homeTeamId
            }
            let awayTeam = teamsArray.filter { (team) -> Bool in
                team.teamId == event.awayTeamId
            }
            
            recentCell?.homeImageCell.sd_setImage(with: URL(string: homeTeam[0].teamBadge!), placeholderImage: UIImage(named: "placeholder"))
            recentCell?.awayImageCell.sd_setImage(with: URL(string: awayTeam[0].teamBadge!), placeholderImage: UIImage(named: "placeholder"))
            recentCell?.awayTeamName.text = awayTeam[0].teamShortName
            recentCell?.homeTeamName.text = homeTeam[0].teamShortName
            recentCell?.homeScore.text = event.homeScore
            recentCell?.awayScore.text = event.awayScore
            switch indexPath.row % 2 {
            case 0:
                recentCell!.backgroundColor = UIColor.systemBlue
            case 1:
                recentCell!.backgroundColor = UIColor.systemPink
            default:
                break
            }
            return recentCell!
            
        default :
            teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: teamReuseIdentifier, for: indexPath) as? TeamCell
            teamCell?.teamImage.sd_setImage(with: URL(string:teamsArray[indexPath.row].teamBadge!), placeholderImage: UIImage(named: "placeholder"))
            return teamCell!
        }
        
        
        
        // Configure the cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        switch collectionView.tag {
        case 3:
            return  CGSize(width: tableView.frame.width/3, height: tableView.frame.height/4.75)
        case 4:
            return CGSize(width: tableView.frame.width/1.2, height: tableView.frame.height/13)
        case 5:
            return  CGSize(width: tableView.frame.width/4, height: tableView.frame.height/8)
        default:
            return  CGSize(width: tableView.frame.width/3, height: tableView.frame.height/2)
        }
    }
    
    
}

