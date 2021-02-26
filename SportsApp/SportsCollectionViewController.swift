//
//  SportsCollectionViewController.swift
//  SportsApp
//
//  Created by Shady Ahmed on 2/25/21.
//  Copyright © 2021 Shady Ahmed. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

private let reuseIdentifier = "SportsCell"

class SportsCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var sports:Array<Sport> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        AF.request("https://www.thesportsdb.com/api/v1/json/1/all_sports.php").validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let sportsArr = json["sports"].arrayValue
                for sport in sportsArr {
                    let sportDic = sport.dictionaryValue
                    let name = sportDic["strSport"]?.stringValue
                    let thumb = sportDic["strSportThumb"]?.stringValue
                    self.sports.append(Sport(sportName: name!, sportThumb: thumb!))
                }
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
            
            
          
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        return sports.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SportsCollectionViewCell
        // Configure the cell
        cell.sportNameLabel.text = sports[indexPath.row].sportName
        cell.sportThumbIV.sd_setImage(with: URL(string: sports[indexPath.row].sportThumb!), placeholderImage: UIImage(named: "placeholder"))
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leaguesTVC = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesTVC") as! LeaguesTableViewController
        leaguesTVC.currentSport = sports[indexPath.row].sportName!
        leaguesTVC.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(leaguesTVC, animated: true)
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
