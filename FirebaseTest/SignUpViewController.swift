//
//  SignUpViewController.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/29/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    //MARK: - STORYBOARD
    
    @IBOutlet var fullName: UITextField!
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    //MARK: - Display Alert
    func displayAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message , preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func signUp(sender: AnyObject) {
        if fullName.text != "" && username.text != "" && password.text != ""{
            
            var signUp = FBUser()
            
            signUp.email = username.text!

            signUp.password = password.text!
            
            signUp[Users.FullName] = fullName.text!
            
            signUp.signUpInBackgroundWithBlock({ (userId, error) -> () in
                if userId != ""{
                    
                    let init_card = FBObject(className: Card.BranchName)
                    init_card.userId = userId;
                    init_card[Card.Email] = self.username.text!
                    init_card[Card.Name] = self.fullName.text!
                    
                    init_card.saveInBackgroundWithBlock({ (success, error) -> () in
                        
                        if success {
                            
                            user.objectId = userId
                            user.email = self.username.text!
                            user.username = self.username.text!
                            
                            let object = FBObject(className: Email.BranchName)
                            object.userId = user.objectId
                            object[Email.Email] = signUp.email
                            object[Email.MyType] = "Personal"
                            object.saveInBackgroundWithBlock({ (success, error) -> () in
                                
                                if (success) {
                                    
                                    user.logInWithUsernameInBackground(self.username.text!, password: self.password.text!) { (myUser, error) -> () in
                                        
                                        if error == ""{
                                            user = myUser!
                                            
                                            connections = FBConnections(userId: user.objectId, branchName: Connections.BranchName)
                                            connections!.prepareArray()
                                            
                                            user.snapshot(user.objectId, completion: { (_snapshot, error) -> () in
                                                
                                                card = DDBusinessCard(userId: user.objectId)
                                                
                                                let emailObjects = FBQuery(className: Email.BranchName)
                                                emailObjects.getArrayOf(user.objectId)
                                                
                                                let phoneNumbersObjects = FBQuery(className: Phone.BranchName)
                                                phoneNumbersObjects.getArrayOf(user.objectId)
                                                
                                                let delay = 2.0 * Double(NSEC_PER_SEC)
                                                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                                                
                                                //TODO: - Activity Indicator
                                                
                                                //sets the user profile image data
                                                user.getDataFromURLWithBlock(user.userImageUrl) { (data, response, error) -> () in
                                                    user.userImageData = data!
                                                }
                                                
                                                dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
                                                    emails = emailObjects.arrayOfObjects
                                                    phoneNumbers = phoneNumbersObjects.arrayOfObjects
                                                    snapshot = _snapshot
                                                    self.performSegueWithIdentifier(Storyboard.SignedUp, sender: self)
                                                }
                                            })
                                            
                                        }else{
                                            
                                            let alert = UIAlertController(title: "", message: error, preferredStyle: .Alert)
                                            
                                            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                                            
                                            self.presentViewController(alert, animated: true, completion: nil)
                                        }
                                    }
                                    
                                } else {
                                    
                                    self.displayAlert("", message: error)
                                    
                                }
                            })
                        } else {
                            self.displayAlert("", message: error)
                        }
                    })
                    
                    
                                    }else{
                    self.displayAlert("", message: error)
                }
            })
        }else{
            print("There was an error loggin in")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

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
