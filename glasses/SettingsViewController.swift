//
//  SettingsViewController.swift
//  glasses
//
//  Created by Cory Jbara on 2/9/17.
//  Copyright © 2017 coryjbara. All rights reserved.
//

import UIKit
import Toast_Swift

class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var nameLabel: UITextField!
    let db = Database.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameLabel.delegate = self;
        nameLabel.text = db.user
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        db.user = nameLabel.text!
        self.view.makeToast("User successfully updated!", duration: 3.0, position: .center)
        return false
    }
    
    @IBAction func saveTouched(_ sender: Any) {
        db.user = nameLabel.text!
        self.view.makeToast("User successfully updated!", duration: 3.0, position: .center)
    }
    
}
