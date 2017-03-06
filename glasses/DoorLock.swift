//
//  DoorLock.swift
//  glasses
//
//  Created by Cory Jbara on 2/12/17.
//  Copyright © 2017 coryjbara. All rights reserved.
//

import Foundation
import Firebase

class DoorLock {
    var time: Date
    var locked: Bool
    var changedBy: String
    
    init() {
        time = Date()
        locked = true
        changedBy = "Cory Jbara"
    }
    
    init(timestamp: Date, wasLocked: Bool, changedBy: String) {
        time = timestamp
        locked = wasLocked
        self.changedBy = changedBy
    }
    
    var timestamp: String {
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d"
        let df2 = DateFormatter()
        df2.dateFormat = "h:mm a"
        
        return df.string(from: time) + "\nat " + df2.string(from: time)
    }
    
    init(snapshot: FIRDataSnapshot) {
        let date = snapshot.childSnapshot(forPath: "timestamp").value as! Double
        
        self.time = Date(timeIntervalSince1970: date/1000)
        self.locked = snapshot.childSnapshot(forPath: "wasLocked").value as! Bool
        self.changedBy = snapshot.childSnapshot(forPath: "changedBy").value as! String
        
    }
}
