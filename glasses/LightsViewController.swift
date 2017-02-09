//
//  LightsViewController.swift
//  glasses
//
//  Created by Cory Jbara on 2/9/17.
//  Copyright © 2017 coryjbara. All rights reserved.
//

import UIKit
import Firebase

class LightsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var history: [Light] = []
    var db: Database = Database()

    @IBOutlet var lightImage: UIImageView!
    @IBOutlet var lightSwitch: UISwitch!
    @IBOutlet var lightsLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBar = self.tabBarController as! TabBarController
        db = tabBar.db
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Check lights
        db.observeLights(lightSwitch: lightSwitch, lightImage: lightImage, lightsLabel: lightsLabel);

        //Check light history
        history.removeAll()
        db.checkLightHistory() {
            (hist) in
            self.history = hist
            self.tableView.reloadData()
        }

        
    }
    
    @IBAction func lightSwitchChanged(_ sender: UISwitch) {
        db.changeLightStatus(isOn: lightSwitch.isOn)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count // your number of cell here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // your cell coding
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryCell
        cell.body.text = "Turned \(self.history[indexPath.row].turnedOn ? "ON" : "OFF") by \(self.history[indexPath.row].changedBy)"
        cell.time.text = history[indexPath.row].timestamp
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // cell selected code here
    }

}
