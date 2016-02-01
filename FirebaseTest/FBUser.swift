//
//  DDUser.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/31/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation


class FBUser:FBObject{
    private var _URL_BASE_USERS:String = "\(URL_BASE)/Users"
    private var _objectId:String?
    private var _username:String?
    private var _password:String?
    private var _email:String?
    private var _dictionary = Dictionary<String, AnyObject>()
    
    //MARK: - Setters and Getters
    var objectId:String{
        get{
            return self._objectId!
        }
    }
    
    var username:String{
        get{
            return self._username!
        }
        set{
            self._username = newValue
            self._dictionary["username"] = newValue
        }
    }
    
    var password:String{
        get{
            return ""
        }
        set{
            self._password = newValue
            
        }
    }
    
    var email:String{
        get{
            return self._email!
        }
        set{
            self._email = newValue
            self._dictionary["email"] = newValue
        }
    }
    
    override var dictionary:Dictionary<String, AnyObject>{
        get{
            return self._dictionary
        }
        set{
            self._dictionary = newValue
        }
    }
    
    //MARK: - Initializers
    convenience init(){
        self.init(className: "Users")
    }
    
    override subscript(key: String) -> AnyObject{
        get {
            return dictionary[key]!
        }
        set {
            self._dictionary[key] = newValue
        }
    }
    
    //MARK: - Functions

    func signUpInBackgroundWithBlock(completionWithBlock:(succeeded:Bool, error: String) -> ()){
        var ref = Firebase(url: self._URL_BASE_USERS)
        var _error = ""
        
        //TODO: - GUARD STATEMENTS FOR ERROR HANDLINGS
        
        
        ref.createUser(self._email, password: self._password) { (error , result) -> Void in
            if error != nil{

                if error.code == ERROR_CODE_EMAIL_TAKEN{
                    _error = "The email already exists in our database. Try another email."
                }else{
                    _error = "There was some type of error"
                }
                completionWithBlock(succeeded: false, error: _error)
            }else{
                if let u = result["uid"]{
                    self._objectId = u as! String
                }

                self.saveInBackgroundWithBlock({ (success, error) -> () in
                    if success{
                        completionWithBlock(succeeded: true, error: "There were NO errors and user is logging in")
                    }else{
                        print(error)
                    }
                })
            }
        }
        
    }
    
    override func saveInBackgroundWithBlock(completionWithBlock: (success: Bool, error: String) -> ()) {
        let URL_BASE_USER_ID = "\(URL_BASE)/Users/"
        let ref = Firebase(url: _URL_BASE_USERS)

        var usersRef = ref.childByAppendingPath(self._objectId)
        usersRef.setValue(self._dictionary)
        completionWithBlock(success: true, error: "")
    }

}






