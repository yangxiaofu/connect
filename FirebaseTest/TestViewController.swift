//
//  TestViewController.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/31/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

//        let query = FBQuery(className: "Users")
//        query.atBranch(branchName: "Phone")
//        
//        query.getObjectsAtBranchWithinIdWithBlock("8c2da262-1af2-428f-9b06-224ee5530031") { (objects, error) -> () in
//            let dictionary = objects as! NSDictionary
//            
//            for (key, value) in dictionary{
//                print(key)
//                print(value)
//            }
//        }
//
//        
//        let query2 = FBQuery(className: "Users")
//
//        
//        query2.getObjectInBackgroundWithId("8c2da262-1af2-428f-9b06-224ee5530031", completionWithBlock: { (object, error) -> () in
//            print(object)
//            print(object.valueForKey("company"))
//        })
//        
        
//        var user = FBUser()
//        
//        user.password = ""
//        
//        user.username = "fudaviddong@gmail.com"
//        
//        user.logInWithUsernameInBackground("fudaviddong@gmail.com", password: "xiao8281") { (user, error) -> () in
//            
//           user?.snapshot((user?.objectId)!, completion: { (snapshot, error) -> () in
//                print(snapshot.value["email"])
//                print(snapshot.value["company"])
//           })
//            
//        }
//
//        
//        
//        var user = FBUser()
//        
//        user.email = "fudaviddong@gmail.com"
//        user.password = "1234"
//        user.username = "yangxiaofu"
//        user["company"] = "Pentair"
//        
//        user.signUpInBackgroundWithBlock { (userId, error) -> () in
//            if userId != ""{
//                print("User has signed UP")
//                print(user.objectId)
//            }else{
//                print(error)
//            }
//        }
//
//        let object = FBObject(className: "Email")
//        object[Email.Email] = "fudaviddong@gmail.com"
//        
//        object.saveInBackgroundWithBlock { (success, error) -> () in
//            if success{
//                print("This was a success saving the information")
//            }else{
//                print(error)
//            }
//        }
//        
//        let object2 = FBObject(className: "Phone")
//        object2.userId = "8c2da262-1af2-428f-9b06-224ee5530031"
//        object2[Email.Email] = "510-730-0660"
//        
//        object2.saveInBackgroundWithBlock { (success, error) -> () in
//            if success{
//                print("This was a success saving the information")
//            }else{
//                print(error)
//            }
//        }
        
        
        
        
        
//
//        
//
//        let phoneObject = FBObject(className: "PhoneNumbers")
//        phoneObject["type"] = "Work"
//        phoneObject["number"] = "510-720-0660"
//        
//        phoneObject.saveInBackgroundWithBlock { (success, error) -> () in
//            if success{
//                print("This was a success again")
//            }else{
//                print("This failed miserably")
//            }
//        }
        
        
        
        
//        
//        
//        let query = FBQuery(className: "Email")
//        
//        query.getObjectInBackgroundWithId("-K9Q5yXsctUuTJZ30HKo") { (object, error) -> () in
//            if error != ""{
//                
//            }else{
//                if let pN = object["playerName"]{
//                    print(pN as! String)
//                }
//            }
//            
//        }
////

        // Do any additional setup after loading the view.
        
//        
//        let user = FBUser()
//        
//        print(user["full_name"])
//        let key = ""
//        let keys = [String()]
//        let userId = "860e3bb0-9fd5-434d-a816-c6e42929a2ae"
//        let url = "\(URL_BASE)/Users/\(userId)/Email"
//        let ref = Firebase(url: url)
//        
//        ref.observeEventType(.Value, withBlock: { snapshot in
//            
//            // 2
//            var keys = [key]
//            
//            // 3
//            for i in snapshot.children {
//                let item = i as! FDataSnapshot
//                
////                print(item.key)
//                keys.append(item.key)
//            }
//            keys.removeAtIndex(0)
//            
//            var emails = [String]()
//            var types = [String]()
//            var userIds = [String]()
//            
//            for x in keys{
//                var url_key = "\(URL_BASE)/Email/\(x)"
//                
//                var refKey = Firebase(url: "\(url_key)")
//                
//                refKey.observeSingleEventOfType(.Value, withBlock: { (snapshot2) -> Void in
//                    emails.append(snapshot2.value["email"] as! String)
//                    types.append(snapshot2.value["type"] as! String)
//                    userIds.append(snapshot2.value["userId"] as! String)
//                    print(emails)
//                    print(types)
//                    print(userIds)
//                })
//
//
//            }
//            
//            // 5
//        })
        
    
//        let emails = FBQuery(className: "Email")
//        emails.getArrayOf("860e3bb0-9fd5-434d-a816-c6e42929a2ae")
//        let delay = 2.0 * Double(NSEC_PER_SEC)
//        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
//        
//        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
//            print(emails.arrayOfObjects)
//        }
        
//        // Save a new business cards
//        let card = DDBusinessCard()
//        card.userId = "860e3bb0-9fd5-434d-a816-c6e42929a2ae"
//        card["name"] = "Fu David Dong"
//        card["company"] = "ERIFLEX | Pentair"
//        card["phoneNumber"] = "510-730-0660"
//        card.saveInBackgroundWithBlock { (success, error) -> () in
//            if success {
//                print("Success")
//            }else{
//                print("Error")
//            }
//        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
