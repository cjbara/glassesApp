//
//  Database.swift
//  glasses
//
//  Created by Cory Jbara on 2/9/17.
//  Copyright © 2017 coryjbara. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class Database {
    
    var ref: FIRDatabaseReference!
    var user: String = "Cory Jbara"
    
    init() {
        
    }
    
    func initialize() {
        ref = FIRDatabase.database().reference()
    }
    
    
    
    
    //Change the light status
    func changeLightStatus(isOn: Bool) {
        ref.child("lights/on").setValue(isOn)
        
        let time = FIRServerValue.timestamp()
        
        //Update the history
        let historyUpdate = ["timestamp": time, "wasTurnedOn": isOn, "changedBy": user] as [String : Any]
        ref.child("lights/history").childByAutoId().setValue(historyUpdate)
        
        //Add a notification
        //let notificationsUpdate = ["type": "lightsOn", "timestamp": time, "value": isOn, "user": user] as [String : Any]
        //ref.child("notifications").childByAutoId().setValue(notificationsUpdate)
    }
    
    //Change the lock status
    func changeLockStatus(isLocked: Bool) {
        ref.child("door/locked").setValue(isLocked)
        
        let time = FIRServerValue.timestamp()
        
        let historyUpdate = ["timestamp": time, "wasLocked": isLocked, "changedBy": user] as [String : Any]
        ref.child("door/history/locked").childByAutoId().setValue(historyUpdate)
        
        //let notificationsUpdate = ["type": "doorLocked", "timestamp": time, "value": isLocked, "user": user] as [String : Any]
        //ref.child("notifications").childByAutoId().setValue(notificationsUpdate)
    }
    
    //Check the status of the lights
    func observeLights(lightSwitch: UISwitch, lightImage: UIImageView, lightsLabel: UILabel) {
        ref.child("lights/on").observe(.value, with: { (snapshot) in
            lightSwitch.isOn = (snapshot.value as! Bool == true)
            lightImage.image = (lightSwitch.isOn ? #imageLiteral(resourceName: "lightsOn") : #imageLiteral(resourceName: "lightsOff"))
            
            lightsLabel.text = "Lights are currently \((lightSwitch.isOn ? "ON" : "OFF"))"
        })
    }
    
    //Check the status of the door
    func observeDoor(doorSwitch: UISwitch, doorImage: UIImageView, doorLabel: UILabel) {
        ref.child("door/locked").observe(.value, with: { (snapshot) in
            doorSwitch.isOn = (snapshot.value as! Bool == true)
            doorImage.image = (doorSwitch.isOn ? #imageLiteral(resourceName: "locked") : #imageLiteral(resourceName: "unlocked"))
            
            doorLabel.text = "Door is currently \((doorSwitch.isOn ? "locked" : "unlocked"))"
        })
    }
    
    //Check for door open
    func observeDoorOpen(doorOpenImage: UIImageView, doorOpenLabel: UILabel) {
        ref.child("door/open").observe(.value, with: { (snapshot) in
            let doorStatus = snapshot.value as! Bool
            doorOpenImage.image = (doorStatus ? #imageLiteral(resourceName: "doorOpen") : #imageLiteral(resourceName: "doorClosed"))
            
            doorOpenLabel.text = "Door is currently \((doorStatus ? "open" : "closed"))"
        })
    }
    
    //Check for window open
    func observeWindowOpen(windowOpenImage: UIImageView, windowOpenLabel: UILabel) {
        ref.child("window/open").observe(.value, with: { (snapshot) in
            let windowStatus = snapshot.value as! Bool
            windowOpenImage.image = (windowStatus ? #imageLiteral(resourceName: "windowOpen") : #imageLiteral(resourceName: "windowClosed"))
            
            windowOpenLabel.text = "Window is currently \((windowStatus ? "open" : "closed"))"
        })
    }
    
    //Check last motion detected
    func observeMotion(motionLabel: UILabel) {
        ref.child("motion/history").observe(.value, with: { (snapshot) in
            
            var lastMotionDate: Date = Date()
            
            if let t = snapshot.value as? TimeInterval {
                // Cast the value to an NSTimeInterval
                // and divide by 1000 to get seconds.
                lastMotionDate = Date(timeIntervalSince1970: t/1000)
            }
            
            let df = DateFormatter()
            df.dateFormat = "EEEE, MMM d"
            let df2 = DateFormatter()
            df2.dateFormat = "h:mm a"
            
            let lastMotion = df.string(from: lastMotionDate) + "\nat " + df2.string(from: lastMotionDate)
            motionLabel.text = lastMotion
        })
    }
    
    //Check temperature status
    func observeTemp(tempLabel: UILabel, heatingCooling: UILabel) {
        ref.child("temp").observe(.value, with: { (snapshot) in
            
            let current = snapshot.childSnapshot(forPath: "current").value as! Int
            let setTo = snapshot.childSnapshot(forPath: "setTo").value as! Int
            
            if current < setTo {
                //Heating
                heatingCooling.text = "Heating to \(setTo)°"
                heatingCooling.textColor = UIColor(red: 227, green: 117, blue: 105)
            } else if current > setTo {
                //Cooling
                heatingCooling.text = "Cooling to \(setTo)°"
                heatingCooling.textColor = UIColor(red: 152, green: 214, blue: 240)
            } else {
                //Neutral
                heatingCooling.text = ""
            }
            
            tempLabel.text = "\(current)°"
            
        })
    }
    
    //Check smoke and CO status
    func observeSmokeAndCO() {
        
    }
    
    //Check the light history
    func checkLightHistory(callback: @escaping ([Light]) -> ()) {
        ref.child("lights/history").queryOrdered(byChild: "timestamp").queryLimited(toFirst: 50)
            .observe(.value, with: { (snapshot) in
                
                var history: [Light] = []
                
                for child in snapshot.children.allObjects as! [FIRDataSnapshot] {
                    let newLight = Light(snapshot: child)
                    
                    history.append(newLight)
                }
                history.reverse()
                callback(history)
            })
    }
}
