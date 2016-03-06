//
//  NavigationBar.swift
//  BConnectTo
//
//  Created by Dave Dong on 2/24/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit

class NavigationBar: UINavigationController {
    
    override func awakeFromNib() {
        self.navigationBar.barTintColor = UIColor(red: 234/255, green: 220/255, blue: 205/255, alpha: 1.0)
        self.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica-light", size: 15)!]
        

    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
