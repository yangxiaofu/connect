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
    private var _loggedIn:Bool = false
    private var _objectId:String!
    private var _username:String?
    private var _password:String?
    private var _email:String?
    private var _dictionary = Dictionary<String, AnyObject>()
    private var _subscriptReturnObject:AnyObject?
    private var _userImageUrl:String?
    private var _userImageData:NSData?
    
    //MARK: - Setters and Getters
    
    var loggedIn:Bool{
        get{
            return self._loggedIn
        }
        set{
            self._loggedIn = newValue
        }
    }
    var objectId:String{
        get{
            return self._objectId!
        }
        set{
            self._objectId = newValue
        }
    }
    
    var username:String{
        get{
            return self._username!
        }
        set{
            self._username = newValue
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
    var userImageUrl:String{
        get{
            return self._userImageUrl!
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
    
    //MARK: - Initializers
    convenience init(){
        self.init(className: "Users")
    }
    
    override subscript(key: String) -> AnyObject{
        get{
            return self._dictionary[key]!
        }
        set {
            self._dictionary[key] = newValue
        }
    }
    
    //MARK: - Functions
    
    func snapshot(id:String, completion:(snapshot:FDataSnapshot, error:String) -> ()){
        let url = "\(URL_BASE)/Users/\(id)"
        
        let ref = Firebase(url: url)
        
        ref.observeEventType(.Value) { (snapshot) -> Void in
            completion(snapshot: snapshot, error: "")
        }
    }

    func signUpInBackgroundWithBlock(completionWithBlock:(userId:String, error: String) -> ()){
        let ref = Firebase(url: self._URL_BASE_USERS)
        var _error = ""
        
        ref.createUser(self._email, password: self._password) { (error , result) -> Void in
            if error != nil{
                if error.code == ERROR_CODE_EMAIL_TAKEN{
                    _error = "The email already exists in our database. Try another email."
                    
                }else if error.code == ERROR_CODE_INVALID_EMAIL{
                    
                    _error = "Invalid Email Address"
                }else{
                    
                    _error = "there was some type of error"
                }
                
                completionWithBlock(userId: "", error: _error)
                
            }else{
                
                if let u = result["uid"]{
                    self._objectId = u as! String
                }

                self.saveInBackgroundWithBlock({ (success, error) -> () in
                    
                    if success{
                        
                        completionWithBlock(userId: self._objectId!, error: "")
                        
                    }else{
                        
                        completionWithBlock(userId: "", error: error)
                        print(error)
                        
                    }
                })
            }
        }
    }
    
    func logOut(){
        let ref = Firebase(url: "\(URL_BASE)")
        print("Loggin user out")
        ref.unauth()
    }
    
    func logInWithUsernameInBackground(username:String, password:String, completionWithBlock:(user: FBUser?, error:String) -> ()){
        
        let ref = Firebase(url: "\(URL_BASE)")
        
        ref.authUser(username, password: password) { (error , AuthData) -> Void in
            if error != nil{
                //An error has occurred
                if error.code == ERROR_CODE_INVALID_PASSWORD{
                    completionWithBlock(user: nil, error: "User has an invalid password")
                }else if error.code == ERROR_CODE_INVALID_USER{
                    completionWithBlock(user: nil, error: "This user does not exist")
                }else if error.code == ERROR_CODE_INVALID_EMAIL{
                    completionWithBlock(user: nil, error: "This is an invalid email")
                }else if error.code == ERROR_CODE_FIREBASE_AUTHENTICATION{
                    completionWithBlock(user: nil, error: "Due to another authentication attempt, this authentication attempt was aborted before it could complete.")
                }else{
                    print(error)
                }
                
            }else{
                //user is logged in, check authData for data
                
                let user = FBUser()
                                
                user.objectId = AuthData.uid
                
                if let ui = AuthData.providerData["profileImageURL"]{
                    user._userImageUrl = ui as! String
                }else{
                    user._userImageUrl = ""
                }

                if let e = AuthData.providerData["email"]{
                    user.email = e as! String
                }else{
                    user.email = ""
                }
                
                if let uImage = AuthData.providerData["profileImageURL"]{
                    user._userImageUrl = uImage as! String
                }
                
                if let u = AuthData.providerData["email"]{
                    user.username = u as! String
                }else{
                    user.username = ""
                }
                
                completionWithBlock(user: user, error: "")
                
            }
        }

    }
    
    override func saveInBackgroundWithBlock(completionWithBlock: (success: Bool, error: String) -> ()) {
        
        let URL_BASE_USER_ID = "\(URL_BASE)/Users/"
        let ref = Firebase(url: _URL_BASE_USERS)
        let usersRef = ref.childByAppendingPath(self._objectId)
        
        usersRef.updateChildValues(self._dictionary)
        
        completionWithBlock(success: true, error: "")
        
    }
   
    func getDataFromURLWithBlock(url:String, completion:(data:NSData?, response:NSURLResponse?, error:NSError?) -> ()){
        let checkedURL = NSURL(string: url)
        NSURLSession.sharedSession().dataTaskWithURL(checkedURL!) { (data, response, error ) -> Void in
            completion(data: data, response: response, error: error)
        }.resume()
    }
    
    func hasAnyObject(className:String, completion:(count:UInt, error: String) -> ()){
        
        var count:UInt = 0
        let url = "\(URL_BASE)/Users/\(self.userId)/\(className)"
        let ref = Firebase(url: url)
        
        ref.observeSingleEventOfType(.Value, withBlock: { (snapshot) -> Void in
            count = snapshot.childrenCount
            completion(count: count, error: "")
        }) { (error) -> Void in
            completion(count: count, error: "there was a problem getting the number of objects")
        }

    }
}






