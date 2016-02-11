//
//  addInfoViewController.swift
//  BConnectTo
//
//  Created by Dave Dong on 2/9/16.
//  Copyright © 2016 Self. All rights reserved.
//

//
//  addInfoViewController.swift
//  BConnect.To
//
//  Created by Dave Dong on 1/17/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

protocol SavedPhoneNumberDelegate{
    func userDidSavePhoneNumber() //Reloads the table
}

class addInfoViewController: UIViewController, TypeSelectedDelegate {
    var itemType:String!
    let numbers = PhoneNumbers()
    var selectedItemType:String = "Personal"
    var delegate:SavedPhoneNumberDelegate?
    
    @IBOutlet var headerLabel: UILabel!
    
    struct Storyboard{
        static let ShowItemTypes = "showItemTypes"
    }
    
    @IBOutlet var number: UITextField!
    
    @IBOutlet var myItemType: UIButton!
    
    //MARK: - IBACTIONS
    
    @IBAction func selectType(sender: AnyObject) {
        let typeSignal = ItemType.Phone
        performSegueWithIdentifier(Storyboard.ShowItemTypes, sender: typeSignal)
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func save(sender: AnyObject) {
        if number.text == ""{
            let alert = UIAlertController(title: "", message: "Please enter a phone number", preferredStyle: .Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil ))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            if self.itemType == ItemType.Phone{
                //TODO: - UPdate Numbers Class
//                user.numbers?.addPhone(self.number.text!, type: self.selectedItemType)
//                self.dismissViewControllerAnimated(true, completion: { () -> Void in
//                    if self.delegate != nil{
//                        print(user.numbers?.phoneNumbers)
//                        self.delegate?.userDidSavePhoneNumber()
//                    }
//                })
                
            }else{
                //TODO: - Update Emails Class
//                user.email?.addEmail(self.number.text!, type: self.selectedItemType)
//                self.dismissViewControllerAnimated(true, completion: { () -> Void in
//                    if self.delegate != nil{
//                        print(user.email.emails)
//                        self.delegate?.userDidSavePhoneNumber()
//                    }
//                    
//                })
                
            }
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myItemType.setTitle("Personal", forState: .Normal)
        
        if itemType == ItemType.Phone{
            headerLabel.text = "Please enter a phone number"
        }else if itemType == ItemType.Email{
            headerLabel.text = "Please enter an email"
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier  == Storyboard.ShowItemTypes{
            let itemTypesVC:ItemTypesTableViewController = segue.destinationViewController as! ItemTypesTableViewController
            itemTypesVC.delegate = self
            if let ts = sender{
                itemTypesVC.typeSignal = ts as! String
            }else{
                itemTypesVC.typeSignal = "error"
            }
        }
    }
    
    //MARK: - Delegates functions
    func userDidSelectItemType(selectedItemType: String) {
        myItemType.setTitle(selectedItemType, forState: .Normal)
        self.selectedItemType = selectedItemType
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
