//
//  DDUser.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/31/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation


class DDUser{
    private var _fullName:String?
    private var _email:String?
    
    var email:String{
        get{
            if let e = self._email{
                return e
            }else{
                return ""
            }
        }
        set{
            self._email = newValue
        }
        
    }
    
    var fullName:String{
        get{
            if let fn = _fullName{
                return fn
            }else{
                return ""
            }
        }
        set{
            self._fullName = newValue
        }
    }
    
    
    
    init(){
        
    }
    
    init(fullName:String, email:String){
        self._fullName = fullName
        self._email = email
    }
}