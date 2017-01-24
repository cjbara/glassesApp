//
//  TabBarControllerViewController.swift
//  glasses
//
//  Created by Cory Jbara on 1/24/17.
//  Copyright © 2017 coryjbara. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    let colors = Colors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.barTintColor = colors.tabBarBackgroundColor
        self.tabBar.tintColor = colors.tabBarItemColor
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
