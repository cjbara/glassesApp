//
//  Colors.swift
//  glasses
//
//  Created by Cory Jbara on 1/24/17.
//  Copyright © 2017 coryjbara. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}

class Colors {
    let tabBarBackgroundColor = UIColor(red: 25, green: 30, blue: 40)
    let tabBarItemColor = UIColor(red: 145, green: 155, blue: 165)
    let selectedTabBarItemColor = UIColor(red: 150, green: 200, blue: 200)
    
    let tileColor = UIColor(red: 45, green: 55, blue: 65)
    let tileBackgroundColor = UIColor(red: 35, green: 40, blue: 50)
    
    let white = UIColor.white
    let green = UIColor(red: 130, green: 200, blue: 165)
    
    init() {
        
    }
}
