//
//  Users.swift
//  BConnect.To
//
//  Created by Dave Dong on 1/13/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation

class MyUser{
    private var _objectId:String?
    private var _url:String?
    private var _ref:Firebase
    private var _userImageURL:String?
    private var _userImageData:NSData?

    var objectId:String{
        get{
            return self._objectId!
        }
    }
    
    var userImageData:NSData{
        get{
            return self._userImageData!
        }
        set{
            self._userImageData = newValue
        }
    }
    
    init(objectId:String){
        self._objectId = objectId
        self._url = "\(URL_BASE)/Users/\(objectId)"
        self._ref = Firebase(url: self._url)
    }
    
}

