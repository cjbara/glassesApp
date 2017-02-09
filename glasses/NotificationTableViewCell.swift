//
//  NotificationTableViewCell.swift
//  glasses
//
//  Created by Cory Jbara on 1/30/17.
//  Copyright © 2017 coryjbara. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    @IBOutlet var notificationImage: UIImageView!
    @IBOutlet var body: UILabel!
    @IBOutlet var secondary: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
