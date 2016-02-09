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
        
        let query = FBQuery(className: "Users")
        query.atBranch(branchName: "Phone")
        
        query.getObjectsAtBranchWithinIdWithBlock("8c2da262-1af2-428f-9b06-224ee5530031") { (objects, error) -> () in
            let dictionary = objects as! NSDictionary
            
            for (key, value) in dictionary{
                print(key)
                print(value)
            }
        }

        
        let query2 = FBQuery(className: "Users")

        
        query2.getObjectInBackgroundWithId("8c2da262-1af2-428f-9b06-224ee5530031", completionWithBlock: { (object, error) -> () in
            print(object)
            print(object.valueForKey("company"))
        })
        
//        var user = FBUser()
//        
//        user.password = "1234"
//        user.username = "fudaviddong@gmail.com"
//        
//        user.logInWithUsernameInBackground("fudaviddon", password: "1234") { (user, error) -> () in
//            print(error )
//            print("spacer")
//            print(user)
//        }
// 
        
        
//        var user = FBUser()
//        
//        user.email = "fudaviddong@gmail.com"
//        user.password = "1234"
//        user.username = "yangxiaofu"
//        user["company"] = "Pentair"
//        
//        user.signUpInBackgroundWithBlock { (succeeded, error) -> () in
//            if succeeded{
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
//        

        // Do any additional setup after loading the view.
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
