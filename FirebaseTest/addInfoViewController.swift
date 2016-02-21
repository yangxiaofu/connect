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

                let object = FBObject(className: Phone.BranchName)
                object.userId = user.objectId
                object[Phone.Number] = self.number.text!
                object[Phone.MyType] = self.selectedItemType
                object.saveInBackgroundWithBlock({ (success, error) -> () in
                    if success {
                        let delay = 1.5 * Double(NSEC_PER_SEC)
                        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                        
                        //TODO: - Activity Indicator
                        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
                            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                                self.delegate?.userDidSavePhoneNumber()
                            })
                        }

                    }else{
                        print("there was an error")
                    }
                })
                
            }else{
                
                let object = FBObject(className: Email.BranchName)
                object.userId = user.objectId
                object[Email.Email] = self.number.text!
                object[Email.MyType] = self.selectedItemType
                object.saveInBackgroundWithBlock({ (success, error) -> () in
                    if success {
                        let delay = 1.5 * Double(NSEC_PER_SEC)
                        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                        
                        //TODO: - Activity Indicator
                        
                        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
                            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                                self.delegate?.userDidSavePhoneNumber()
                            })
                        }
                        
                    }else{
                        print("there was an error")
                    }
                })

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
