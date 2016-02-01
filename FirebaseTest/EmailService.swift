//
//  EmailService.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/31/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation


class EmailService:DataService{
    static let es = EmailService()
    
    private var _REF_EMAILS = Firebase(url: "\(URL_BASE)/emails")
    
    private var _REF_USER_EMAILS = Firebase(url: "\(URL_BASE)/users/\(ds.uniqueUserId)/emails")
    
    var REF_EMAILS:Firebase{
        return _REF_EMAILS
    }
    
    var REF_USER_EMAILS:Firebase{
        return _REF_USER_EMAILS
    }
    
    func createFireBaseEmail(unique_id:String, var email:Dictionary<String, String>) throws {
        
        guard unique_id != "" else{
            throw createFireBaseEmailError.UniqueIDNonExistent
        }
        
        guard email["type"] != "" else{
            throw createFireBaseEmailError.InvalidType
        }
        
        guard email["email"] != "" else{
            throw createFireBaseEmailError.InvalidEmail
        }
        
        
        email = [
            Email.OwnerUniqueID: uniqueUserId
        ]
        
        let email_reference = REF_EMAILS.childByAutoId()
        
        email_reference.setValue(email)
        
        let email_id = email_reference.key
        
        
        //Attached a objects of email to base/users/unique_user_id/emails
        
        let emailObjects = [
            email_id: true
        ]
        
        print("Creating the email tree")
        print(uniqueUserId)
        
        REF_USER_EMAILS.setValue(emailObjects)
        
    }
    
}