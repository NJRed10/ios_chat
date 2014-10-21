//
//  MessageCell.swift
//  cpchat
//
//  Created by Niaz Jalal on 9/29/14.
//  Copyright (c) 2014 Niaz Nabib. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
