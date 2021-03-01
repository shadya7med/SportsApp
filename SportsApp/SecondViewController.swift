//
//  SecondViewController.swift
//  SportsApp
//
//  Created by Shady Ahmed on 2/18/21.
//  Copyright © 2021 Shady Ahmed. All rights reserved.
//

import UIKit
private let reuseIdentifier = "Cell"
class SecondViewController: UITableViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    var id:String?
    
    
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
    

    @IBOutlet weak var upComingEventCollController: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        upComingEventCollController.delegate = self
        upComingEventCollController.dataSource = self
        
        // Do any additional setup after loading the view.
        print("ID: \(id!)")
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
