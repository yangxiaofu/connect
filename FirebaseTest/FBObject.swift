//
//  FBObject.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/31/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

class FBObject{
    private var _ref = Firebase(url: URL_BASE)
    
    private var _URL_BASE_CLASSNAME:String?
    
    private var _dictionary = Dictionary<String, AnyObject>()
    
    private var _className:String?
    
    //MARK: - Getters and Setters
    
    var className:String{
        get{
            return self._className!
        }
        set{
            self._className = newValue
        }
    }
    
    var URL_BASE_CLASSNAME:String{
        get{
            return self._URL_BASE_CLASSNAME!
        }
        set{
            self._URL_BASE_CLASSNAME = newValue
        }
    }
    
    var ref:Firebase{
        get{
            return self._ref
        }
    }
    
    var dictionary:Dictionary<String, AnyObject>{
        get{
            return _dictionary
        }
        set{
            _dictionary = newValue
        }
    }
    
    subscript(key: String) -> AnyObject{
        get {
            return dictionary[key]!
        }
        set {
            self._dictionary[key] = newValue
        }
    }
    
    //MARK: - Initializers
    
    init(className className:String){

        self._className = className

        URL_BASE_CLASSNAME = "\(URL_BASE)/\(className)"
    }
    
    func saveInBackgroundWithBlock(completionWithBlock:(success:Bool, error: String) -> ()){
        
        let objectsRef = ref.childByAppendingPath(self._className)
        
        let objects1Ref = objectsRef?.childByAutoId()
        
        objects1Ref?.setValue(self._dictionary)
        
        completionWithBlock(success: true, error: "")
    }
    
}