//
//  SportsTabBarController.swift
//  SportsApp
//
//  Created by Shady Ahmed on 3/3/21.
//  Copyright © 2021 Shady Ahmed. All rights reserved.
//

import UIKit

class SportsTabBarController: UITabBarController {

    let gradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        if gradientLayer.superlayer != nil {
                gradientLayer.removeFromSuperlayer()
            }
            let topColor = UIColor(red: 16.0/255.0, green: 12.0/255.0, blue: 54.0/255.0, alpha: 1.0)
            let bottomColor = UIColor(red: 57.0/255.0, green: 33.0/255.0, blue: 61.0/255.0, alpha: 1.0)
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
            gradientLayer.frame = tabBar.bounds
            
            self.tabBar.layer.insertSublayer(gradientLayer, at: 0)
        
        
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
