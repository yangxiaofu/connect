//
//  LoginViewController.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/29/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    
    @IBOutlet var password: UITextField!

    @IBAction func login(sender: AnyObject) {
        if email.text != "" && password.text != ""{
            DataService.ds.logIn(email.text!, password: password.text!) { (success, error) -> () in
                if success {
                    self.performSegueWithIdentifier(Storyboard.LoggedIn, sender: self)
                }else{
                    let alert = UIAlertController(title: "", message: error, preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil ))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
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
