//
//  GrayButtons.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/29/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit

class GrayButtons: UIButton {

    override func awakeFromNib() {
        let backgroundColor:UIColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0)
        let textColor:UIColor = UIColor.blackColor()
        let borderWidth:CGFloat = 0.5
        let cornerRadius:CGFloat = 10.0
        
        self.backgroundColor = backgroundColor
        self.tintColor = textColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0).CGColor
        
    }

}
