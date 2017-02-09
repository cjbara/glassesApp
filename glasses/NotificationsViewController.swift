//
//  NotificationsViewController.swift
//  glasses
//
//  Created by Cory Jbara on 1/30/17.
//  Copyright © 2017 coryjbara. All rights reserved.
//

import UIKit
import Firebase

class NotificationsViewController: UITableViewController {
    
    var notifications: [Notification] = []
    var ref: FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        refreshData()
        
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = UIColor.white
        refreshControl?.addTarget(self, action: #selector(NotificationsViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
    }
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        notifications.removeAll()
        ref.child("notifications").queryOrdered(byChild: "timestamp").queryLimited(toFirst: 50).observeSingleEvent(of: .value, with: { (snapshot) in
            
            for child in snapshot.children.allObjects as! [FIRDataSnapshot] {
                let newNotif = Notification(snapshot: child)
                
                self.notifications.append(newNotif)
            }
            self.notifications.reverse()
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func refreshData() {
        ref.child("notifications").queryOrdered(byChild: "timestamp").queryLimited(toFirst: 50).observeSingleEvent(of: .value, with: { (snapshot) in
            
            for child in snapshot.children.allObjects as! [FIRDataSnapshot] {
                let newNotif = Notification(snapshot: child)
                
                self.notifications.append(newNotif)
            }
            self.notifications.reverse()
            self.tableView.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notifications.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! NotificationTableViewCell
        
        let notification = notifications[indexPath.row]
        
        return notification.returnCell(cell: cell)
    }
 
}
