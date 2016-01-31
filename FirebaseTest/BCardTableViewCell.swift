//
//  BCardTableViewCell.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/30/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit

class BCardTableViewCell: UITableViewCell {

    @IBOutlet var userImage: CircularImage!
   
    @IBOutlet var company: bConnect!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var headline: UILabel!
    
    @IBOutlet var email: UILabel!
    
    @IBOutlet var number: UILabel!
}
