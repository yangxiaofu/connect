//
//  RedSignInButton.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/29/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit

class RedSignInButton: UIButton {
    override func awakeFromNib() {
        let backgroundColor:UIColor = UIColor(red: 255/255, green: 54/255, blue: 46/255, alpha: 1.0)
        let textColor:UIColor = UIColor.whiteColor()
        let cornerRadius:CGFloat = 2.0
        
        self.backgroundColor = backgroundColor
        self.tintColor = textColor
        self.layer.cornerRadius = cornerRadius
    }
}
