//
//  Image.swift
//  glasses
//
//  Created by Cory Jbara on 3/5/17.
//  Copyright © 2017 coryjbara. All rights reserved.
//

import Foundation
import Firebase

class ImageData {
    var url: String
    var time: Date
    
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
        self.url = snapshot.childSnapshot(forPath: "url").value as! String
        
    }
}
