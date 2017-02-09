//
//  Notification.swift
//  glasses
//
//  Created by Cory Jbara on 1/30/17.
//  Copyright © 2017 coryjbara. All rights reserved.
//

import Foundation
import UIKit
import Firebase

enum NotificationType: String {
    case doorLocked = "doorLocked"
    case doorOpen = "doorOpen"
    case lightsOn = "lightsOn"
    case tempChanged = "tempChanged"
    case motionDetected = "motionDetected"
    case windowOpen = "windowOpen"
}

class Notification {
    var type: NotificationType
    var timestamp: Date
    var user: String?
    var value: Bool?
    
    var time: String {
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d"
        let df2 = DateFormatter()
        df2.dateFormat = "h:mm a"
        
        return df.string(from: timestamp) + "\nat " + df2.string(from: timestamp)
    }
    
    var image: UIImage {
        switch type {
        case .doorLocked:
            if value == true {
                return #imageLiteral(resourceName: "locked")
            } else {
                return #imageLiteral(resourceName: "unlocked")
            }
        case .doorOpen:
            if value == true {
                return #imageLiteral(resourceName: "doorOpen")
            } else {
                return #imageLiteral(resourceName: "doorClosed")
            }
        case .lightsOn:
            if value == true {
                return #imageLiteral(resourceName: "lightsOn")
            } else {
                return #imageLiteral(resourceName: "lightsOff")
            }
        case .tempChanged: return #imageLiteral(resourceName: "thermostat")
        case .motionDetected: return #imageLiteral(resourceName: "motion")
        case .windowOpen:
            if value == true {
                return #imageLiteral(resourceName: "windowOpen")
            } else {
                return #imageLiteral(resourceName: "windowClosed")
            }
        }
    }
    
    var body: String {
        switch type {
        case .doorLocked:
            if value == true {
                return "Door was locked by \(user!)"
            } else {
                return "Door was unlocked by \(user!)"
            }
        case .doorOpen:
            if value == true {
                return "Door was opened"
            } else {
                return "Door was closed"
            }
        case .lightsOn:
            if value == true {
                return "Lights were turned on by \(user!)"
            } else {
                return "Lights were turned off by \(user!)"
            }
        case .tempChanged: return "Temperature was changed"
        case .motionDetected: return "Motion was detected"
        case .windowOpen:
            if value == true {
                return "Window was opened"
            } else {
                return "Window was closed"
            }
        }
    }

    var secondary: String {
        return time
//        switch type {
//        case .doorLocked: return time
//        case .doorOpen: returm time
//            if value == true {
//                return #imageLiteral(resourceName: "doorOpen")
//            } else {
//                return #imageLiteral(resourceName: "doorClosed")
//            }
//        case .lightsOn:
//            if value == true {
//                return #imageLiteral(resourceName: "lightsOn")
//            } else {
//                return #imageLiteral(resourceName: "lightsOff")
//            }
//        case .tempChanged: return #imageLiteral(resourceName: "thermostat")
//        case .motionDetected: return #imageLiteral(resourceName: "motion")
//        case .windowOpen:
//            if value == true {
//                return #imageLiteral(resourceName: "windowOpen")
//            } else {
//                return #imageLiteral(resourceName: "windowClosed")
//            }
//        }
    }
    
    init(type: String, time: Date, value: Bool?, user: String?) {
        self.type = NotificationType.init(rawValue: type)!
        timestamp = time
        self.value = value
        self.user = user
    }
    
    init(snapshot: FIRDataSnapshot) {
        let notifType = snapshot.childSnapshot(forPath: "type").value as! String
        let date = snapshot.childSnapshot(forPath: "timestamp").value as! Double
        
        self.type = NotificationType.init(rawValue: notifType)!
        self.timestamp = Date(timeIntervalSince1970: date/1000)
        
        self.value = nil
        self.user = nil
        if snapshot.childSnapshot(forPath: "value").exists() {
            self.value = snapshot.childSnapshot(forPath: "value").value as! Bool?
        }
        if snapshot.childSnapshot(forPath: "user").exists() {
            self.user = snapshot.childSnapshot(forPath: "user").value as! String?
        }
    
    }
    
    func returnCell(cell: NotificationTableViewCell) -> NotificationTableViewCell {
        cell.notificationImage.image = self.image
        
        cell.body.text = self.body
        cell.secondary.text = self.secondary
        
        return cell
    }
}
