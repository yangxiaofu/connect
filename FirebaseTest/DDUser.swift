//
//  DDUser.swift
//  BConnectTo
//
//  Created by Dave Dong on 2/10/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

class DDUser{
    private var _userId:String?
    private var _objectId:String?
    private var _email:String?
    
    //MARK: - Setters and Getters
    var userId:String{
        get{
            return self._userId!;
        }
    }
    
    var objectId:String{
        get{
            return self._objectId!
        }
    }
    
    var email:String{
        get{
            return self._email!
        }
    }
    
    init(){
        
    }
    
    
}