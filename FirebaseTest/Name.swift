////
////  Name.swift
////  BConnect.To
////
////  Created by Dave Dong on 1/21/16.
////  Copyright © 2016 Parse. All rights reserved.
////
//
//import Foundation
//
class Name{
    var firstName:String = ""
    var lastName:String = ""
    var middleName:String = ""
    private var _fullName:String = ""
    
    var fullName:String{
        get{
            return _fullName
        }
        set{
            _fullName = newValue
        }
    }
    
    init(){
        
        
        
        user.snapshot(user.objectId) { (snapshot, error) -> () in
            if let fn = snapshot.value[Users.FullName]{
                self.fullName = fn as! String
                
                let name = self.separateNameAsDictionary(self.fullName)
                
                self.firstName = name["firstName"]!
                self.middleName = name["middleName"]!
                self.lastName = name["lastName"]!
            }
        }
    }
    
    init(fullName:String){
        self._fullName = fullName
    }
    
    func separateNameAsDictionary(fullName:String) -> Dictionary<String, String>{
        var nameDictionary = Dictionary<String, String>()
        let fullNameArray = fullName.componentsSeparatedByString(" ")
        
        switch fullNameArray.count{
        case 0:
            nameDictionary["firstName"] = ""
            nameDictionary["lastName"] = ""
            nameDictionary["middleName"] = ""
        case 1:
            nameDictionary["firstName"] = fullNameArray[0]
            nameDictionary["middleName"] = ""
            nameDictionary["lastName"] = ""
        case 2:
            nameDictionary["firstName"] = fullNameArray[0]
            nameDictionary["middleName"] = ""
            nameDictionary["lastName"] = fullNameArray[1]
        case 3:
            nameDictionary["firstName"] = fullNameArray[0]
            nameDictionary["middleName"] = fullNameArray[1]
            nameDictionary["lastName"] = fullNameArray[2]
        default:
            nameDictionary["firstName"] = fullNameArray[0]
            nameDictionary["middleName"] = ""
            nameDictionary["lastName"] = fullNameArray[fullNameArray.count - 1]
        }
        
        return nameDictionary
        
    }
    /*
    func separateName(fullName:String!){
        let fullNameArray = fullName.componentsSeparatedByString(" ")
        print("inside the seprate name loop")
        
        switch fullNameArray.count{
        case 0:
            self.firstName = ""
            self.middleName = ""
            self.lastName = ""
        case 1:
            self.firstName = fullNameArray[0]
            self.middleName = ""
            self.lastName = ""
        case 2:
            self.firstName = fullNameArray[0]
            self.middleName = ""
            self.lastName = fullNameArray[1]
        case 3:
            self.firstName = fullNameArray[0]
            self.middleName = fullNameArray[1]
            self.lastName = fullNameArray[2]
        default:
            self.firstName = fullNameArray[0]
            self.middleName = ""
            self.lastName = fullNameArray[fullNameArray.count - 1]
        }
    }
    
    func updateName(firstName:String!, middleName:String!, lastName:String!) {
        user["first_name"] = firstName
        user["last_name"] = lastName
        user["middle_name"] = middleName

        user.saveInBackgroundWithBlock { (success, error) -> () in
            if success{
                print("success")
            }else{
                print(error)
            }
        }

//        PFUser.currentUser()?[UserClass.firstName] = firstName
//        PFUser.currentUser()?[UserClass.lastName] = lastName
//        PFUser.currentUser()?[UserClass.middleName] = middleName
//        PFUser.currentUser()?.saveInBackgroundWithBlock({ (succeeded, error ) -> Void in
//            if succeeded{
//                print("success")
//            }else{
//                print(error)
//            }
//            
//            
//        })
    }
    */
    
}
