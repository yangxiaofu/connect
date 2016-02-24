//
//  ContactCellTableViewCell.swift
//  BConnectTo
//
//  Created by Dave Dong on 2/24/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit

class ContactCellTableViewCell: UITableViewCell {
    
    @IBOutlet var fullName: UILabel!
    @IBOutlet var headline: UILabel!
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor(red: 248/255, green: 245/255, blue: 240/255, alpha: 1.0)
    }
}
