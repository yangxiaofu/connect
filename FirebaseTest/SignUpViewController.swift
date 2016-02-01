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
    
    @IBAction func signUp(sender: AnyObject) {
        if fullName.text != "" && username.text != "" && password.text != ""{
            DataService.ds.signUp(username.text!, password: password.text!, completionWithBlock: { (uid, succeeded, error) -> () in
                if succeeded{
                    
                    var user = Dictionary<String, String>()
                    
                    user = [
                        User.FullName: self.fullName.text!
                    ]
                    
                    DataService.ds.createFireBaseUser(uid, user: user)
                    
                    do{
                        var email = Dictionary<String, String>()

                        email = [
                            "type": "Work",
                            "email": self.username.text!
                        ]

                        try EmailService.es.createFireBaseEmail(uid, email: email)
                        
                    } catch {
                        
                        print("There was some type of error")
                        
                    }
                    
                    
                    self.performSegueWithIdentifier(Storyboard.SignedUp, sender: self)
                }else{
                    let alert = UIAlertController(title: "", message: error, preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
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
