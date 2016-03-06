//
//  UserImageGreenBorder.swift
//  BConnectTo
//
//  Created by Dave Dong on 3/5/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit

class UserImageGreenBorder: UIImageView {

    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.size.width / 2.0
        self.layer.borderColor = UIColor(red: 0/255, green: 171/255, blue: 175/255, alpha: 1.0).CGColor
        self.layer.borderWidth = 4.0
        self.clipsToBounds = true
    }

}
