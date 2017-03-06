//
//  DoorLockViewController.swift
//  glasses
//
//  Created by Cory Jbara on 2/9/17.
//  Copyright © 2017 coryjbara. All rights reserved.
//

import UIKit
import Firebase

class DoorLockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var history: [DoorLock] = []
    let db = Database.sharedInstance

    @IBOutlet var doorImage: UIImageView!
    @IBOutlet var doorSwitch: UISwitch!
    @IBOutlet var doorLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Check door
        db.observeDoor(doorSwitch: doorSwitch, doorImage: doorImage, doorLabel: doorLabel);

        //Check door history
        history.removeAll()
        db.checkDoorLockHistory() {
            (hist) in
            self.history = hist
            self.tableView.reloadData()
        }

        
    }
    
    @IBAction func doorSwitchChanged(_ sender: UISwitch) {
        db.changeLockStatus(isLocked: doorSwitch.isOn)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count // your number of cell here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // your cell coding
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryCell
        cell.body.text = "\(self.history[indexPath.row].locked ? "LOCKED" : "UNLOCKED") by \(self.history[indexPath.row].changedBy)"
        cell.time.text = history[indexPath.row].timestamp
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // cell selected code here
    }

}
