//
//  Users.swift
//  BConnect.To
//
//  Created by Dave Dong on 1/13/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation

class MyUser{

    private var _userId:String!
    var userId:String{
        get{
            return _userId
        }
        set{
            
        }
    }
    
    private var _myUsername:String?
    var myUserName:String{
        get{
            return _myUsername!
        }
        set{
            _myUsername = newValue
        }
    }
    
    lazy var isNew:Bool = true
//    var name:Name!
//    var info:Info?
    var email:Emails!
    var numbers:PhoneNumbers?
    var primaryEmail:String!
    var primaryNumber = ""
    var businessCard:BusinessCard!
    //TODO: - Work on the UIImagePicker solution
//    var userImage:UserImage?
    
    init(){
        //TODO: - convert to FBUse.
        self._userId = user.objectId
        self._myUsername = user.username
//        self.name = Name()
//        self.info = Info()
//        self.email = Emails()
//        self.numbers = PhoneNumbers()
//        self.userImage = UserImage()
//        self.primaryEmail = PFUser.currentUser()?.username!
//        if let pn = PFUser.currentUser()![UserClass.primaryNumber]{
//            self.primaryNumber = pn as! String
//        }
        self.businessCard = BusinessCard()
    }
    
    //TODO: - WORK ON SAVE ALL Function. .
    func saveAll(){
        //TODO: - Convert to FB User
//        if let myU = _myUsername{
//            PFUser.currentUser()![UserClass.myUsername] = myU
//        }
//        
//        PFUser.currentUser()![UserClass.primaryEmail] = primaryEmail
//        PFUser.currentUser()![UserClass.primaryNumber] = primaryNumber
//        
//        //Emails
//        PFUser.currentUser()![UserClass.workEmail] = self.email.work
//        PFUser.currentUser()![UserClass.personalEmail] = self.email.personal
//        PFUser.currentUser()![UserClass.otherEmail] = self.email.other
//        
//        //Phones
//        PFUser.currentUser()![UserClass.workNumber] = self.numbers?.work
//        PFUser.currentUser()![UserClass.personalNumber] = self.numbers?.personal
//        PFUser.currentUser()![UserClass.faxNumber] = self.numbers?.fax
//        PFUser.currentUser()![UserClass.otherEmail] = self.numbers?.other
//        
//        //Information
//        PFUser.currentUser()![UserClass.headline] = self.info?.headline
//        PFUser.currentUser()![UserClass.company] = self.info?.company
//        
//        //Name
//        self.name.separateName(self.name.fullName)
//        PFUser.currentUser()![UserClass.firstName] = self.name.firstName
//        PFUser.currentUser()![UserClass.lastName] = self.name.lastName
//        PFUser.currentUser()![UserClass.middleName] = self.name.middleName
//        
//        PFUser.currentUser()?.saveInBackground()
    }
    
    func setPrimaryEmail(email:String){
        //TODO: - Convert to FBUser
//        let user = PFObject(className: UserClass.className)
//        user.setValue(email, forKey: UserClass.primaryEmail)
//        
//        user.saveInBackgroundWithBlock { (success, error ) -> Void in
//            if error == nil{
//                print("saving primary Email was successfull")
//            }else{
//                print("saving primary email was not successfull")
//            }
//        }
        
    }
    
    func setPrimaryNumber(number:String){
        //TODO: - Convert to FBUser
//        let user = PFObject(className: UserClass.className)
//        user.setValue(number, forKey: UserClass.primaryNumber)
//        
//        user.saveInBackgroundWithBlock { (success, error ) -> Void in
//            if error == nil{
//                print("saving primary Number was successfull")
//            }else{
//                print("saving primary Number was not successfull")
//            }
//        }
    }
}

