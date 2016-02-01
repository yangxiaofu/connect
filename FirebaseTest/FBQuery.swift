//
//  FBQuery.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/31/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

class FBQuery:FBObject{
    private var _URL_BASE_CLASSNAME_ID:String?
    
    var URL_BASE_CLASSNAME_ID:String{
        get{
            return self._URL_BASE_CLASSNAME_ID!
        }
    }
    
    override init(className className:String){
        super.init(className: className)
        
        self.className = className
        
        URL_BASE_CLASSNAME = "\(URL_BASE)/\(className)"
    }
    
    func getObjectInBackgroundWithId(id:String, completionWithBlock:(object: AnyObject, error:String ) -> ()){
        _URL_BASE_CLASSNAME_ID  = "\(URL_BASE_CLASSNAME)/\(id)"
        var ref = Firebase(url: self._URL_BASE_CLASSNAME_ID)
        
        ref.observeSingleEventOfType(.Value, withBlock: { (snapshot) -> Void in
            completionWithBlock(object: snapshot.value, error: "")
            
        })
            
        { (error ) -> Void in
            print(error)
            completionWithBlock(object: "", error: "There was an error")
        
        }
        
        
    }
}