//
//  Lights.swift
//  glasses
//
//  Created by Cory Jbara on 2/9/17.
//  Copyright © 2017 coryjbara. All rights reserved.
//

import Foundation
import Firebase

class Light {
    var time: Date
    var turnedOn: Bool
    var changedBy: String
    
    init() {
        time = Date()
        turnedOn = true
        changedBy = "Cory Jbara"
    }
    
    init(timestamp: Date, wasTurnedOn: Bool, changedBy: String) {
        time = timestamp
        turnedOn = wasTurnedOn
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
        self.turnedOn = snapshot.childSnapshot(forPath: "wasTurnedOn").value as! Bool
        self.changedBy = snapshot.childSnapshot(forPath: "changedBy").value as! String
        
    }
}
