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
                    user.objectId = userId
                    let object = FBObject(className: Email.BranchName)
                    
                    object.userId = user.objectId
                    object[Email.Email] = signUp.email
                    object.saveInBackgroundWithBlock({ (success, error) -> () in
                        
                        if (success) {
                            
                            var user = FBUser()
                            
                            user.logInWithUsernameInBackground(self.username.text!, password: self.password.text!) { (user, error) -> () in
                                
                                if user == nil{

                                    self.displayAlert("", message: error)
                                    
                                }else{

                                    self.performSegueWithIdentifier(Storyboard.SignedUp, sender: self)
                                    
                                }
                                
                            }
                            
                            self.performSegueWithIdentifier(Storyboard.SignedUp, sender: self)

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
