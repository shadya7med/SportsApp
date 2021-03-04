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

class FavouriteLeaguesTableViewController: UITableViewController ,LeagueVideoButtonDelegate{

    var leagues = Array<League>()
    var leaguesResultSet = Array<NSManagedObject>()

    let  gradientLayer = CAGradientLayer()
     
     
    override func viewDidLayoutSubviews() {
         
         
         
         if gradientLayer.superlayer != nil {
             gradientLayer.removeFromSuperlayer()
         }
         let topColor = UIColor(red: 16.0/255.0, green: 12.0/255.0, blue: 54.0/255.0, alpha: 1.0)
         let bottomColor = UIColor(red: 57.0/255.0, green: 33.0/255.0, blue: 61.0/255.0, alpha: 1.0)
         gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
         gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
         gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
         gradientLayer.frame = view.bounds
         let backgroundView = UIView(frame: view.bounds)
         backgroundView.layer.insertSublayer(gradientLayer, at: 0)
         self.tableView.backgroundView = backgroundView
         
         
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let viewContext = appDelegate.persistentContainer.viewContext
        let leaguesEntity = NSEntityDescription.entity(forEntityName: "Leagues",in: viewContext)!
        let leagueRequest = NSFetchRequest<NSManagedObject>(entityName: "Leagues")
        do{
            leaguesResultSet = try viewContext.fetch(leagueRequest)
            for item in leaguesResultSet {
                leagues.append(League(leagueId: item.value(forKey: "id") as! String, leagueName: item.value(forKey: "leagueName") as! String, leagueBadge: item.value(forKey: "leagueBadge") as! String, leagueLink: item.value(forKey: "leagueYTUrl") as! String))
            }
            tableView.reloadData()
        }catch let error as Error{
            print(error)
        }
        
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
        cell.link = leagues[indexPath.row].leagueLink
        cell.linkDelegate = self
        
        cell.leagueVideoBtn.layer.cornerRadius = 15
        cell.leagueVideoBtn.layer.borderWidth = 1
        cell.leagueVideoBtn.layer.borderColor = UIColor.black.cgColor
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let svc = self.storyboard?.instantiateViewController(identifier: "SecondVC") as! LeagueTableViewController
        svc.id = leagues[indexPath.row].leagueId!
        svc.modalPresentationStyle = .fullScreen
        present(svc, animated: true, completion: nil)
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
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let viewContext = appDelegate.persistentContainer.viewContext
            let leaguesEntity = NSEntityDescription.entity(forEntityName: "Leagues",in: viewContext)!
            
            viewContext.delete(leaguesResultSet[indexPath.row])
            leagues.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
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
               if(link != nil)
               {
                   //open the link in safari instead
                   let youtubeUrl = URL(string:"https://\(link)")!
                   UIApplication.shared.openURL(youtubeUrl)
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
