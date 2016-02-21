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
        self.frame = CGRectMake(100, 100, 100, 100)
        self.layer.cornerRadius = self.frame.size.width / 2.0
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 5.0
        self.clipsToBounds = true
        
    }

}
