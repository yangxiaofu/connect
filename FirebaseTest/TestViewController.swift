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
        
        let object = FBObject(className: "Email")
        object["playerName"] = "Rob"
        object["userId"] = "8c2da262-1af2-428f-9b06-224ee5530031"
        object.saveInBackgroundWithBlock { (success, error) -> () in
            if success{
                print("Success")
            }else{
                print("Failed")
            }
        }
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
