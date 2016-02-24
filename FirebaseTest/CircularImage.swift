//
//  CircularImage.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/30/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit

class CircularImage: UIImageView {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.size.width / 2.0
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 1.0
        self.clipsToBounds = true
    }

}
