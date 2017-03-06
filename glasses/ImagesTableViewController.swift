//
//  ImagesTableViewController.swift
//  glasses
//
//  Created by Cory Jbara on 3/5/17.
//  Copyright © 2017 coryjbara. All rights reserved.
//

import UIKit
import Nuke
import Toast_Swift

class ImagesTableViewController: UITableViewController {

    let colors = Colors()
    let db = Database.sharedInstance
    var images: [ImageData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = colors.tabBarBackgroundColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = UIColor.white
        refreshControl?.addTarget(self, action: #selector(ImagesTableViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        
        refreshData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageTableViewCell

        let url = URL(string: images[indexPath.row].url)
        Nuke.loadImage(with: url!, into: cell.pictureView)
        
        cell.timestamp.text = images[indexPath.row].timestamp

        return cell
    }
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshData()
    }
    
    func refreshData() {
        db.getAllImages { (newImages) in
            self.images = newImages
            self.images.reverse()
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        self.view.makeToastActivity(.center)
        db.takeNewImage { (success) in
            if success == true {
                self.refreshData()
                self.view.hideToastActivity()
                self.view.makeToast("Took new picture", duration: 3.0, position: .center)
            } else {
                self.view.hideToastActivity()
                self.view.makeToast("Could not take new picture", duration: 3.0, position: .center)
            }
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
