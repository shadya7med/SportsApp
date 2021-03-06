//
//  FavouriteLeaguesTableViewController.swift
//  SportsApp
//
//  Created by Shady Ahmed on 2/25/21.
//  Copyright © 2021 Shady Ahmed. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData
import Alamofire
class FavouriteLeaguesTableViewController: UITableViewController ,LeagueVideoButtonDelegate{

    var leagues = Array<Leagues>()
    var leaguesResultSet = Array<NSManagedObject>()
    let coreData = MyCoreDataClass.shared
    let  gradientLayer = CAGradientLayer()
    let alertView = UIAlertController(title: "League Url", message: "League url not available", preferredStyle: UIAlertController.Style.alert)
    let alertAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
    let noConnectionAlert = UIAlertController(title: "No Connection", message: "No Internt Connection", preferredStyle: .alert)
    
    override func viewDidLayoutSubviews() {
         alertView.addAction(alertAction)
         
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
         self.tableView.backgroundView = backgroundView
         
         
     }
    
    override func viewWillAppear(_ animated: Bool) {
        noConnectionAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            if #available(iOS 10.0, *) {
                let appSettings = URL(string: UIApplication.openSettingsURLString)
                UIApplication.shared.open(appSettings!, options: [:], completionHandler: nil)
            
            }
        }))
        noConnectionAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        leagues = coreData.fetchfromCoreData()
        tableView.reloadData()
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//        let viewContext = appDelegate.persistentContainer.viewContext
//        let leagueRequest = NSFetchRequest<NSManagedObject>(entityName: "Leagues")
//        do{
//            leaguesResultSet = try viewContext.fetch(leagueRequest)
//            for item in leaguesResultSet {
//                leagues.append(League(leagueId: item.value(forKey: "id") as! String, leagueName: item.value(forKey: "leagueName") as! String, leagueBadge: item.value(forKey: "leagueBadge") as! String, leagueLink: item.value(forKey: "leagueYTUrl") as! String))
//            }
//            tableView.reloadData()
//        }catch let error{
//            print(error)
//        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaguesCell", for: indexPath) as! LeaguesTableViewCell

        // Configure the cell...
        cell.leagueBadgeIV.sd_setImage(with: URL(string: leagues[indexPath.row].leagueBadge!), completed: nil)
        cell.leagueNameLabel.text = leagues[indexPath.row].leagueName
        cell.link = leagues[indexPath.row].leagueYTUrl
        cell.linkDelegate = self
        
        cell.leagueVideoBtn.layer.cornerRadius = 15

        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //check for connectivity
        NetworkReachabilityManager(host:"https://www.thesportsdb.com/api/v1/json/1/all_sports.php")?.startListening{ status in
        switch status {
        case .notReachable:
          
            self.present(self.noConnectionAlert, animated: true, completion: nil)

        case .reachable(.cellular):
            fallthrough
        case .reachable(.ethernetOrWiFi):
            let svc = self.storyboard?.instantiateViewController(identifier: "SecondVC") as! LeagueTableViewController
            svc.id = self.leagues[indexPath.row].id!
            let league = self.leagues.filter { (League) -> Bool in
                return League.id == svc.id
            }
            svc.leagueName = league[0].leagueName
            svc.leagueUrl = league[0].leagueYTUrl
            svc.leagueBadge = league[0].leagueBadge
            svc.modalPresentationStyle = .fullScreen
            self.present(svc, animated: true, completion: nil)
        case .unknown:
            print("unknown netowrk state")
            }
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//            let viewContext = appDelegate.persistentContainer.viewContext
//
//
//            viewContext.delete(leaguesResultSet[indexPath.row])

            coreData.deleteFromCoreData(id: leagues[indexPath.row].id!)
            leagues.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/4
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/4
    }

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
    // MARK:  - cell link Delegate
       func cellButtonTapped(link: String) {
               //check if there's a url
               if(link != "")
               {
                   //open the link in safari instead
                   let youtubeUrl = URL(string:"https://\(link)")!
                  UIApplication.shared.open(youtubeUrl, options: [:], completionHandler: nil)
               }
        else
               {
                self.present(alertView, animated: true, completion: nil)
        }
               
           
           
       }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
