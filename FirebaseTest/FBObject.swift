//
//  FBObject.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/31/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

class FBObject{
    private var _date = NSDate()
    
    private var _ref = Firebase(url: URL_BASE)
    
    private var _URL_BASE_CLASSNAME:String?
    
    private var _dictionary = Dictionary<String, AnyObject>()
    
    private var _className:String?
    
    private var _userId:String?
    
    //MARK: - Getters and Setters
    
    var userId:String{
        get{
            return self._userId!
        }
        set{
            self._userId = newValue
            self._dictionary["userId"] = newValue
        }
    }
    
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
            return self._dictionary
        }
        set{
            self._dictionary = newValue
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
        
        var userId:String = ""
        
        let objectsRef = ref.childByAppendingPath(self._className)
        let objects1Ref = objectsRef?.childByAutoId()
        objects1Ref?.setValue(self._dictionary)
        
        if let uId = self._userId{
            userId = uId
        }
        
        if userId != ""{
            if let tempId = objects1Ref?.key{
                let id = tempId
                let URL_BASE_USER_CLASSNAME = "\(URL_BASE)/Users/\(userId)/\(self._className!)"
                let userRef = Firebase(url: "\(URL_BASE_USER_CLASSNAME)")
                //TODO: - UPDATE THE VALUE AND DO NOT OVERWRITE
                let objectDictionary = [
                    id: true
                ]
                
                userRef.updateChildValues(objectDictionary)
                completionWithBlock(success: true, error: "")
                
            }else{
                
                completionWithBlock(success: false, error: "There was an error trying to save the object key into the user field.")
                
            }
            
        }else{
            
            completionWithBlock(success: true, error: "")
            
        }
        
    }
    
   
    func removeObject(key:String) throws {
        guard self._className != nil else{
            throw RemoveObjectError.NoClassName
        }
        
        guard user.objectId != "" else{
            throw RemoveObjectError.NoUserIdentified
        }
        
        let url_ref = "\(URL_BASE)/\(className)/\(key)"
        let ref = Firebase(url: url_ref)
        
        ref.removeValue()
        
        let url_user_ref = "\(URL_BASE)/Users/\(user.objectId)/\(className)/\(key)"
        let user_ref = Firebase(url: url_user_ref)
        
        user_ref.removeValue()
    }
}