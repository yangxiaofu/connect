//
//  PhoneNumbers.swift
//  BConnectTo
//
//  Created by Dave Dong on 2/9/16.
//  Copyright © 2016 Self. All rights reserved.
//

//
//  PhoneNumbers.swift
//  BConnect.To
//
//  Created by Dave Dong on 1/21/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation

class PhoneNumbers{
    var work:String = ""
    var personal:String = ""
    var fax:String = ""
    var other:String = ""
    var type:String?
    var count:Int = 0
    var phoneNumbers = [""]
    var phoneTypes = [""]
    var phoneObjectId = [""]
    var types = ["Personal", "Work", "Fax", "Other"]
    var defaultType:String = "Personal"
    
    init(){
    //TODO: - Update FBUser.
//        setPhones((PFUser.currentUser()?.objectId)!)
//        self.defaultType = "Personal"
//        
//        //TODO: - CONSIDER REMOVIGN THIS BECAUSE NOW I HAVE JUST CREATED THE ARRAY
//        
//        if let wn = PFUser.currentUser()?[UserClass.workNumber]{
//            self.work = wn as! String
//        }
//        
//        if let hm = PFUser.currentUser()?[UserClass.personalNumber]{
//            self.personal = hm as! String
//        }
//        
//        if let f = PFUser.currentUser()?[UserClass.faxNumber]{
//            self.fax = f as! String
//        }
//        
//        if let on = PFUser.currentUser()?[UserClass.otherNumber]{
//            self.other = on as! String
//        }
        
    }
    
    /*
    Updates and overwrites new phone information with existing phone information
    */
    
    func updatePhoneNumberInBlockWithId(objectId:String, number:String, type:String, completion:(succeeded:Bool, error: String) -> ()){
        //TODO: - Update with FBQuery
//        let query = PFQuery(className: PhoneClass.ClassName)
//        
//        query.getObjectInBackgroundWithId(objectId) { (object , error ) -> Void in
//            if error != nil{
//                print(error)
//                completion(succeeded: false, error: "There was a problem saving the information on Parse.")
//            }else if let object = object{
//                object[PhoneClass.Number] = number
//                object["type"] = type
//                object.saveInBackground()
//                completion(succeeded: true, error: "")
//            }
//        }
    }
    
    /*
    This function will reset the arrays that are used for the TableView controllers when you reload the data
    */
    func setPhones(userId:String) -> Void{
        
        phoneObjectId.removeAll(keepCapacity: true)
        phoneNumbers.removeAll(keepCapacity: true)
        phoneTypes.removeAll(keepCapacity: true)
        
        phoneNumbers = [""]
        phoneTypes = [""]
        phoneObjectId = [""]

        //TODO: Update the FPQUERY model
//        let query = PFQuery(className: PhoneClass.ClassName)
//        query.whereKey("userId", equalTo: userId)
//        
//        query.findObjectsInBackgroundWithBlock { (objects, error ) -> Void in
//            if error == nil{
//                if let objects = objects {
//                    for object in objects{
//                        user.numbers?.count = objects.count
//                        if let pn = object[PhoneClass.Number]{
//                            if let pt = object["type"]{
//                                self.phoneObjectId.append(object.objectId!)
//                                self.phoneNumbers.append(pn as! String)
//                                self.phoneTypes.append(pt as! String)
//                            }
//                        }
//                    }
//                    self.phoneObjectId.removeAtIndex(0)
//                    self.phoneNumbers.removeAtIndex(0)
//                    self.phoneTypes.removeAtIndex(0)
//                    
//                }
//            }
//        }
    }
    
    func addPhone(number:String, type:String) -> Void{
            //TODO: - Update the FBObject modal.
//        let object = PFObject(className: PhoneClass.ClassName)
//        
//        object[PhoneClass.Number] = number
//        
//        object["type"] = type
//        
//        object[PhoneClass.UserId] = PFUser.currentUser()?.objectId!
//        
//        object.saveInBackgroundWithBlock { (succeeded, error ) -> Void in
//            if succeeded{
//                self.setPhones((PFUser.currentUser()?.objectId)!)
//                print("saved phone number")
//            }else{
//                print(error)
//            }
//        }
        //TODO: - think about adding a phone save functionality. Should this go into an array or shoudl I just use PFUser?
    }
    
    func removePhone(objectId:String){
        //TODO: - Update FBQuery model
//        let query = PFQuery(className: PhoneClass.ClassName)
//        query.getObjectInBackgroundWithId(objectId) { (object , error ) -> Void in
//            object?.deleteInBackground()
//        }
    }
}
