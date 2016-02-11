//
//  Emails.swift
//  BConnect.To
//
//  Created by Dave Dong on 1/21/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation

class Emails{
    var work:String = ""
    var personal:String = ""
    var other:String = ""
    var emailObjectId = [""]
    var emails = [""]
    var emailTypes = [""]
    var count:Int = 0
    var types = ["Personal", "Work", "Other"]
    
    init(){
        //TODO: - convert to FBUser.
//        self.setEmails((PFUser.currentUser()?.objectId)!)
//        
//        if let we = PFUser.currentUser()?[UserClass.workEmail]{
//            self.work = we as! String
//        }
//        if let he = PFUser.currentUser()?[UserClass.personalEmail]{
//            self.personal = he as! String
//        }
//        if let oe = PFUser.currentUser()?[UserClass.otherEmail]{
//            self.other = oe as! String
//        }
    }
    
    func setEmails(userId:String){
        emailObjectId.removeAll(keepCapacity: true)
        emails.removeAll(keepCapacity: true)
        emailTypes.removeAll(keepCapacity: true)
        
        emails = [""]
        emailTypes = [""]
        emailObjectId = [""]
        
        //TODO: - convert to FBUser
//        let query = PFQuery(className: EmailClass.ClassName)
//        query.whereKey("userId", equalTo: userId)
//        
//        query.findObjectsInBackgroundWithBlock { (objects, error ) -> Void in
//            if error == nil{
//                if let objects = objects {
//                    for object in objects{
//                        user.email?.count = objects.count
//                        if let pn = object[EmailClass.Email]{
//                            if let pt = object["type"]{
//                                self.emailObjectId.append(object.objectId!)
//                                self.emails.append(pn as! String)
//                                self.emailTypes.append(pt as! String)
//                            }
//                        }
//                    }
//                    self.emailObjectId.removeAtIndex(0)
//                    self.emails.removeAtIndex(0)
//                    self.emailTypes.removeAtIndex(0)
//                }
//            }
//        }
    }
    
    func addEmail(email:String, type:String) -> Void{
        //MARK: - Convert to FBUser
//        let object = PFObject(className: EmailClass.ClassName)
//        
//        object[EmailClass.Email] = email
//        object["type"] = type
//        object[EmailClass.UserId] = PFUser.currentUser()?.objectId!
//        
//        object.saveInBackgroundWithBlock { (succeeded, error ) -> Void in
//            if succeeded{
//                self.setEmails((PFUser.currentUser()?.objectId)!)
//                print("saved email successfully")
//            }else{
//                print(error)
//            }
//        }
    }
    
    func removeEmail(objectId:String){
        //TODO: - CONVERT to FBUser
//        let query = PFQuery(className: EmailClass.ClassName)
//        query.getObjectInBackgroundWithId(objectId) { (object , error ) -> Void in
//            object?.deleteInBackground()
//        }
    }
}
