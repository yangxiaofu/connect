//
//  ViewController.swift
//  FirebaseTest
//
//  Created by Dave Dong on 1/29/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct Storyboard{
        static let SignUp = "SignUp"
        static let Login = "Login"
    }
    
    @IBOutlet var login: GrayButtons!

    @IBOutlet var register: GrayButtons!
    
    
    //MARK: - @IBACTIONS
    
    @IBAction func loginButton(sender: AnyObject) {
        performSegueWithIdentifier(Storyboard.Login, sender: self)
    }
    
    @IBAction func registerButton(sender: AnyObject) {
        performSegueWithIdentifier(Storyboard.SignUp, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

