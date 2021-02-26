//
//  LeagueTableViewController.swift
//  SportsApp
//
//  Created by Said Elsoudany on 2/25/21.
//  Copyright © 2021 Shady Ahmed. All rights reserved.
//

import UIKit
private let reuseIdentifier = "Cell"
class LeagueTableViewController: UITableViewController {
    var height : CGFloat?
    @IBOutlet weak var upComingEventCollController: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        upComingEventCollController.delegate = self
        upComingEventCollController.dataSource = self
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSize.init(width: tableView.frame.width/2.5, height: tableView.frame.height/4)
        flowLayout.scrollDirection = .horizontal
        upComingEventCollController.collectionViewLayout = flowLayout
        // Do any additional setup after loading the view.
    }
       
        
        override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            height = tableView.frame.height/3
            return height!
        }
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return tableView.frame.height/3
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
extension LeagueTableViewController : UICollectionViewDataSource,UICollectionViewDelegate
{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
               return 10;
           }
           
           func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
               switch indexPath.row % 2 {
               case 0:
                   cell.backgroundColor = UIColor.systemBlue
               case 1:
                   cell.backgroundColor = UIColor.systemPink
               default:
                   break
               }
           
               // Configure the cell
           
               return cell
           }
      
}
