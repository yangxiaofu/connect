//
//  DDTabBar.swift
//  BConnectTo
//
//  Created by Dave Dong on 2/25/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit

class DDTabBar: UITabBar {
    
    override func awakeFromNib() {
        self.barTintColor = UIColor(red: 239/255, green: 81/255, blue: 82/255, alpha: 1.0);

    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}


class DDTabBarItem: UITabBarItem{
    
    override func awakeFromNib() {
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor(red: CGFloat(1), green: CGFloat(1), blue: CGFloat(1), alpha: CGFloat(1))], forState: UIControlState.Normal)

    }
}