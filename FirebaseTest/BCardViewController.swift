//
//  bCardViewController.swift
//  BConnect.To
//
//  Created by Dave Dong on 1/13/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class bCardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SavedPhoneNumberDelegate, UserSavedInformationDelegate{
    var myItemType:String!
    
    struct Storyboard {
        static let AddInfo = "addInfo"
        static let EditVCard = "editVCard"
        static let Logout = "logout"
    }
    
    @IBOutlet var tblView: UITableView!
    //MARK: - @IBAction Buttons
    
    
    @IBAction func logout(sender: AnyObject) {
    //TODO - Update logout
//        PFUser.logOut()
        performSegueWithIdentifier(Storyboard.Logout, sender: self)
    }
    
    @IBAction func editVCard(sender: AnyObject) {
        performSegueWithIdentifier(Storyboard.EditVCard, sender: self)
        
    }
    
    @IBAction func addPhone(sender: AnyObject) {
        myItemType = ItemType.Phone
        performSegueWithIdentifier(Storyboard.AddInfo, sender: myItemType)
    }
    
    
    @IBAction func addEmail(sender: AnyObject) {
        myItemType = ItemType.Email
        performSegueWithIdentifier(Storyboard.AddInfo, sender: myItemType)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "vCard"
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TABLEVIEW
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("socialCell", forIndexPath: indexPath) as! SocialTableViewCell
            return cell
        case 1: //bcard Cell
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! bCardCell
            
            //TODO: - Need to update the user class.
//            cell.userImage.image = user.userImage?.image
//            cell.fullName.text = user.businessCard.fullName
//            cell.company.text = user.businessCard.company
//            cell.headline.text = user.businessCard.headline
//            cell.email.text = user.businessCard.email
//            cell.number.text = user.businessCard.phoneNumber
            
            return cell
        case 2: //Add Phone Cell
            let cell = tableView.dequeueReusableCellWithIdentifier("phoneCell", forIndexPath: indexPath) as! phoneCellTableViewCell
            //TODO: - need to update the phone class
//            cell.phoneType.text = user.numbers!.phoneTypes[indexPath.row]
//            cell.personalPhone.text = user.numbers!.phoneNumbers[indexPath.row]
            
            return cell
            
        case 3:
            //TODO: - Update the cell with a button to add a cell.
            let cell = tableView.dequeueReusableCellWithIdentifier("addPhone", forIndexPath: indexPath)
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier("emailCell", forIndexPath: indexPath) as! EmailTableViewCell
            //TODO: - Need to update the emial class.
//            cell.emailType.text = user.email.emailTypes[indexPath.row]
//            cell.email.text = user.email.emails[indexPath.row]
            return cell
        case 5:
            //TODO: - Update the cell with a button to add a cell.
            let cell = tableView.dequeueReusableCellWithIdentifier("addEmail", forIndexPath: indexPath)
            
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("otherCell", forIndexPath: indexPath)
            cell.textLabel?.text = "Cell"
            return cell
        }
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0: //Social Media
            return 1
        case 1: //vCard
            //TODO: - Add potentially multiple cards later on.
            return 1
        case 2: //Phone Numbers
            return 1
            //TODO; - Need to udpate the phone number class
//            return (user.numbers?.phoneNumbers.count)!
        case 3: //Phone Numbers
            return 1
        case 4: //Emails
            //TODO: - Need to udpat ethe emails class
//            return (user.email?.emails.count)!
            return 1
        case 5: //Add Email
            return 1
        default:
            return 1
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height:CGFloat = 44.0
        
        switch indexPath.section{
        case 0: //vCard
            height = 95.0
        case 1: //Phone Numbers
            height = 215.0
        case 2: // Emails
            height = 65.0
        case 3: // Social Media
            height = 65.0
        default:
            height = 65.0
            
        }
        return height
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section{
        case 0:
            //TODO: - PROGRAM CARD SHARING BUTTON
            break
        case 1: //vCard
            break
        case 2: //Phone Numbers
            break
        case 3: //Email
            break
        default:
            break
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        switch indexPath.section{
        case 2, 4:
            return true
        default:
            return false
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            switch indexPath.section{
            case 2: //Phone Numbers
                //TODO: - Need to update the users class
//                let objectId = user.numbers?.phoneObjectId[indexPath.row]
//                user.numbers?.removePhone(objectId!)
//                user.numbers?.phoneNumbers.removeAtIndex(indexPath.row)
//                user.numbers?.phoneObjectId.removeAtIndex(indexPath.row)
//                user.numbers?.phoneTypes.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            case 4:
                //TODO: - Need to update teh users class
//                let objectId = user.email.emailObjectId[indexPath.row]
//                user.email.removeEmail(objectId)
//                user.email.emails.removeAtIndex(indexPath.row)
//                user.email.emailObjectId.removeAtIndex(indexPath.row)
//                user.email.emailTypes.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                
            default:
                print("Do nothing")
            }
        }
    }
    
    //MARK: - Storyboard
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.AddInfo{
            let addInfoVC:addInfoViewController = segue.destinationViewController as! addInfoViewController
            
            if let iT = sender{
                addInfoVC.itemType = iT as! String
                addInfoVC.delegate = self
            }
        }else if segue.identifier == Storyboard.EditVCard{
//            let editVCardVC:EditBCardViewController = segue.destinationViewController as! EditBCardViewController
//            editVCardVC.delegate = self
        }
    }
    
    //MARK: - Delegate Functions
    func userDidSavePhoneNumber() {
        tblView.reloadData()
    }
    
    func UserDidSaveInfo(){
        tblView.reloadData()
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
