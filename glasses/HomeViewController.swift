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

    let colors = Colors()
    let db = Database.sharedInstance
    
    @IBOutlet var lightImage: UIImageView!
    @IBOutlet var lightSwitch: UISwitch!
    @IBOutlet var lightsLabel: UILabel!
    
    @IBOutlet var doorImage: UIImageView!
    @IBOutlet var doorSwitch: UISwitch!
    @IBOutlet var doorLabel: UILabel!
    
    @IBOutlet var doorOpenImage: UIImageView!
    @IBOutlet var doorOpenLabel: UILabel!
    
    @IBOutlet var windowOpenImage: UIImageView!
    @IBOutlet var windowOpenLabel: UILabel!
    
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var heatingCooling: UILabel!
 
    @IBOutlet var motionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db.initialize()
        
        self.navigationController?.navigationBar.barTintColor = colors.tabBarBackgroundColor;
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white];

        //Ste up all listeners to Firebase db
        checkStatuses()
                
    }

    @IBAction func lightSwitchChanged(_ sender: UISwitch) {
        db.changeLightStatus(isOn: self.lightSwitch.isOn)
    }
    
    @IBAction func doorSwitchChanged(_ sender: UISwitch) {
        db.changeLockStatus(isLocked: self.doorSwitch.isOn)
    }
    
    func checkStatuses() {
        
        //Check lights
        db.observeLights(lightSwitch: lightSwitch, lightImage: lightImage, lightsLabel: lightsLabel);
        
        //Check door
        db.observeDoor(doorSwitch: doorSwitch, doorImage: doorImage, doorLabel: doorLabel)
        db.observeDoorOpen(doorOpenImage: doorOpenImage, doorOpenLabel: doorOpenLabel)

        //Check window
        db.observeWindowOpen(windowOpenImage: windowOpenImage, windowOpenLabel: windowOpenLabel)
        
        //Check motion
        db.observeMotion(motionLabel: motionLabel)
        
        //Check temp
        db.observeTemp(tempLabel: tempLabel, heatingCooling: heatingCooling)
        
        //Check smoke and CO
        
    }

}

