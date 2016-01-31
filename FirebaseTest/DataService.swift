//
//  DataService.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/30/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

class DataService{
    static let ds = DataService()
    
    private var _REF_USERS = Firebase(url: "\(URL_BASE)/users")
    
    var REF_USERS:Firebase{
        return _REF_USERS
    }
    
    func createFireBaseUser(uid: String, user: Dictionary<String, String>){
        REF_USERS.childByAppendingPath(uid).setValue(user)
    }
    
    //MARK: - User Login and Sign up
    
    func signUp(email:String, password:String, completionWithBlock:(uid:String, succeeded:Bool, error:String) -> ()){
        let ref = Firebase(url: "\(URL_BASE)")
        
        ref.createUser(email, password: password,
            
            withValueCompletionBlock: { error, result in
                if error != nil {
                    // There was an error creating the account
                    if error.code == ERROR_CODE_EMAIL_TAKEN{
                        completionWithBlock(uid: "", succeeded: false, error: "This email has already been taken")
                    }else{
                        completionWithBlock(uid: "", succeeded: false, error: "Error Signing up")
                    }

                } else {
                    let uid = result["uid"] as? String
                    
                    NSUserDefaults.standardUserDefaults().setValue(uid, forKey: KEY_UID)
                    
                    completionWithBlock(uid: uid!, succeeded: true, error: "")
                }
        })
    }
    
    func logIn(email:String, password:String, completionWithBlock:(success: Bool, error:String) -> ()){
        let ref = Firebase(url: "\(URL_BASE)")
        ref.authUser(email, password: password,
            withCompletionBlock: { error, authData in
                if error != nil {
                    // There was an error logging in to this account
                    if error.code == ERROR_CODE_INVALID_PASSWORD{
                        completionWithBlock(success: false, error: "The password is invalid")
                    }else if error.code == ERROR_CODE_FIREBASE_AUTHENTICATION{
                        completionWithBlock(success: false, error: "This authentication was aborted before it could be completed")
                    }else{
                        print(error)
                        completionWithBlock(success: false, error: "There was another type of error")
                    }
                    
                } else {
                    // We are now logged in
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
                    completionWithBlock(success: true, error: "")
                }
        })
    }
}


















