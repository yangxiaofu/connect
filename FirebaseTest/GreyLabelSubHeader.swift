//
//  GreyLabelSubHeader.swift
//  BConnectTo
//
//  Created by Dave Dong on 3/5/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit

class GreyLabelSubHeader: UILabel {
    
    override func awakeFromNib() {
        self.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.font = UIFont(name: "Helvetica-light", size: 15)
    }

}
