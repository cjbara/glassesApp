//
//  ViewController.swift
//  glasses
//
//  Created by Cory Jbara on 1/24/17.
//  Copyright © 2017 coryjbara. All rights reserved.
//

/* 
 Sensors:
    Door - open/closed
    Window - open/closed
    Lock - locked/unlocked (and by which user)
    Motion - last motion seen (time)
    Thermostat - currently at ____
        - currently set at ____
        - set by
        - heating/cooling
    Smoke
    CO
 */

import UIKit
import Firebase

class HomeViewController: UIViewController {
    var ref: FIRDatabaseReference!
    @IBOutlet var lightImage: UIImageView!
    @IBOutlet var lightSwitch: UISwitch!
    @IBOutlet var lightsLabel: UILabel!
    
    @IBOutlet var doorImage: UIImageView!
    @IBOutlet var doorSwitch: UISwitch!
    @IBOutlet var doorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        checkStatuses()
    }

    @IBAction func lightSwitchChanged(_ sender: UISwitch) {
        ref.child("lights").setValue(["on": lightSwitch.isOn])
    }
    
    @IBAction func doorSwitchChanged(_ sender: UISwitch) {
        ref.child("door/locked").setValue(doorSwitch.isOn)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func checkStatuses() {
        ref = FIRDatabase.database().reference()
        
        //Check lights
        ref.child("lights/on").observe(.value, with: { (snapshot) in
            self.lightSwitch.isOn = (snapshot.value as! Bool == true)
            self.lightImage.image = (self.lightSwitch.isOn ? #imageLiteral(resourceName: "lightsOn") : #imageLiteral(resourceName: "lightsOff"))
            
            self.lightsLabel.text = "Lights are currently \((self.lightSwitch.isOn ? "on" : "off"))"
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //Check door
        ref.child("door/locked").observe(.value, with: { (snapshot) in
            self.doorSwitch.isOn = (snapshot.value as! Bool == true)
            self.doorImage.image = (self.doorSwitch.isOn ? #imageLiteral(resourceName: "locked") : #imageLiteral(resourceName: "unlocked"))
            
            self.doorLabel.text = "Door is currently \((self.doorSwitch.isOn ? "locked" : "unlocked"))"
        }) { (error) in
            print(error.localizedDescription)
        }
    }

}

