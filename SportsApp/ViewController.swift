//
//  ViewController.swift
//  SportsApp
//
//  Created by Shady Ahmed on 2/18/21.
//  Copyright © 2021 Shady Ahmed. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let testVC = segue.destination
        testVC.modalPresentationStyle = .fullScreen
        
        
        
    }
    
}

