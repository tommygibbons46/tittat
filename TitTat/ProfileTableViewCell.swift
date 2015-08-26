//
//  ProfileTableViewCell.swift
//  TitTat
//
//  Created by Thomas Gibbons on 8/20/15.
//  Copyright (c) 2015 Thomas Gibbons. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var pictureImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func transactionTap(sender: AnyObject) {
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
