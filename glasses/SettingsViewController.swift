//
//  SettingsViewController.swift
//  glasses
//
//  Created by Cory Jbara on 2/9/17.
//  Copyright © 2017 coryjbara. All rights reserved.
//

import UIKit
import Toast_Swift

class SettingsViewController: UIViewController {

    @IBOutlet var nameLabel: UITextField!
    var db: Database = Database()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBar = self.tabBarController as! TabBarController
        db = tabBar.db

        nameLabel.text = db.user
    }
    
    @IBAction func saveTouched(_ sender: Any) {
        db.user = nameLabel.text!
        self.view.makeToast("User successfully updated!", duration: 3.0, position: .center)
    }
    
}
