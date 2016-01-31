//
//  EditBusinessCardViewController.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/30/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit

class EditBusinessCardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    var company:String = ""
    var headline:String = ""
    var name:String = ""
    
    @IBAction func save(sender: AnyObject) {
        
        if let uid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID){
            var card = Dictionary<String, String>()
            
            card = [
                Card.Name: name,
                Card.Company: company,
                Card.Headline: headline
            ]
            
            BusinessCard.card.createFirebaseCard(uid as! String, card: card)
        }

        
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        
        switch textField.tag {
        case 0: //Company
            if let comp = textField.text{
                company = comp
            }
        case 1: //Name
            if let n = textField.text{
                name = n
            }
        case 2: //Headline
            if let h = textField.text{
                headline = h
            }
        default:
            break;
        }
        
        return true
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("EditBusinessCard", forIndexPath: indexPath) as! EditBusinessCardTableViewCell
            
            cell.company.text = "BConnectTest"
            cell.company.delegate = self
            
            cell.headline.text = "Direct of BC"
            cell.headline.delegate = self
            
            cell.name.text = "David Dong"
            cell.name.delegate = self
            
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("DefaultCell", forIndexPath: indexPath)
            
            return cell
        }
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
