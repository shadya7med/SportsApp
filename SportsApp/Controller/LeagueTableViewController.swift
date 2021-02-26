//
//  LeagueTableViewController.swift
//  SportsApp
//
//  Created by Said Elsoudany on 2/25/21.
//  Copyright © 2021 Shady Ahmed. All rights reserved.
//

import UIKit
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
    let arrayOfTeamsLogo = ["https://www.thesportsdb.com//images//media//team//badge//uyhbfe1612467038.png","https://www.thesportsdb.com//images//media//team//badge//aofmzk1565427581.png"]
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
        recentEventCollController.collectionViewLayout.collectionView?.backgroundColor = UIColor.systemGray
        
        tableView.tableHeaderView?.backgroundColor = tableView.backgroundColor
        // Do any additional setup after loading the view.
    }
    
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.height/4.2
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/4.2
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
            numOfItems = 20
        case 4 :
            numOfItems = 9
        default :
            numOfItems = arrayOfTeamsLogo.count
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
            
            upComingCell?.homeTeamImage.sd_setImage(with: URL(string: "https://www.thesportsdb.com//images//media//team//badge//uyhbfe1612467038.png"), placeholderImage: nil)
            upComingCell?.awayTeamImage.sd_setImage(with: URL(string: "https://www.thesportsdb.com//images//media//team//badge//aofmzk1565427581.png"), placeholderImage: nil)
            upComingCell?.awayTeamName.text = "Aston Villa"
            upComingCell?.homeTeamName.text = "Arsenal"
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
            
            recentCell?.homeImageCell.sd_setImage(with: URL(string: "https://www.thesportsdb.com//images//media//team//badge//uyhbfe1612467038.png"), placeholderImage: nil)
            recentCell?.awayImageCell.sd_setImage(with: URL(string: "https://www.thesportsdb.com//images//media//team//badge//aofmzk1565427581.png"), placeholderImage: nil)
            recentCell?.awayTeamName.text = "Asv"
            recentCell?.homeTeamName.text = "Ars"
            
            return recentCell!
            
        default :
            teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: teamReuseIdentifier, for: indexPath) as? TeamCell
            teamCell?.teamImage.sd_setImage(with: URL(string:arrayOfTeamsLogo[indexPath.row]), placeholderImage: nil)
            return teamCell!
        }
        
        
        
        // Configure the cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        switch collectionView.tag {
        case 3:
            return  CGSize(width: tableView.frame.width/3, height: tableView.frame.height/5)
        case 4:
            return CGSize(width: tableView.frame.width/1.2, height: tableView.frame.height/13)
        case 5:
            return  CGSize(width: tableView.frame.width/3, height: tableView.frame.height/8)
        default:
            return  CGSize(width: tableView.frame.width/3, height: tableView.frame.height/2)
        }
    }
    
    
}
