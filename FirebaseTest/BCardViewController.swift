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
        user.logOut()
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
    
    override func viewWillAppear(animated: Bool) {
        tblView.reloadData()
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

            cell.userImage.image = UIImage(data: user.userImageData )
            cell.fullName.text = card.name
            cell.company.text = card.company
            cell.headline.text = card.headline
            cell.email.text = card.email
            cell.number.text = card.phoneNumber
            
            return cell
        case 2: //Add Phone Cell
            let cell = tableView.dequeueReusableCellWithIdentifier("phoneCell", forIndexPath: indexPath) as! phoneCellTableViewCell
            
            cell.phoneType.text = phoneNumbers[PHONE_TYPE][indexPath.row]
            cell.personalPhone.text = phoneNumbers[PHONE_NUMBER][indexPath.row]
            
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("addPhone", forIndexPath: indexPath)
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier("emailCell", forIndexPath: indexPath) as! EmailTableViewCell
            
            cell.emailType.text = emails[EMAIL_TYPE][indexPath.row]
            cell.email.text = emails[EMAIL_ADDRESS][indexPath.row]
            return cell
        case 5:
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
            return phoneNumbers[PHONE_NUMBER].count
        case 3: //Phone Numbers
            return 1
        case 4: //Emails
            return emails[EMAIL_ADDRESS].count
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

                let key = phoneNumbers[PHONE_KEY][indexPath.row]
                
                let object = FBObject(className: Phone.BranchName)
                
                do{
                    try object.removeObject(key)

                    if phoneNumbers[PHONE_NUMBER][indexPath.row] == card.phoneNumber{
                        card.phoneNumber = ""
                        card.updateCard()
                    }
                    
                    phoneNumbers[PHONE_NUMBER].removeAtIndex(indexPath.row)
                    phoneNumbers[PHONE_TYPE].removeAtIndex(indexPath.row)
                    phoneNumbers[PHONE_KEY].removeAtIndex(indexPath.row)
                    
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                } catch {
                    print("There was no class name attached to this")
                }
                
            case 4:
                
                let key = emails[EMAIL_KEY][indexPath.row]
                
                
                let object = FBObject(className: Email.BranchName)
                
                
                do{
                    try object.removeObject(key)
                    
                    if emails[EMAIL_ADDRESS][indexPath.row] == card.email{
                        card.email = ""
                        card.updateCard()
                    }
                    
                    emails[EMAIL_ADDRESS].removeAtIndex(indexPath.row)
                    emails[EMAIL_TYPE].removeAtIndex(indexPath.row)
                    emails[EMAIL_KEY].removeAtIndex(indexPath.row)
                    
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)

                } catch {
                    print("There was no class name attached to this")
                }
                
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
            
            let editVCardVC:EditBCardViewController = segue.destinationViewController as! EditBCardViewController
            
            editVCardVC.delegate = self
        }
    }
    
    
    //MARK: - Delegate Functions
    func userDidSavePhoneNumber(object: Dictionary<String, String>) {

        
        if object["itemType"] == ItemType.Phone{
            
            phoneNumbers[PHONE_NUMBER].append(object["object"]!)
            phoneNumbers[PHONE_TYPE].append(object["type"]!)
            phoneNumbers[PHONE_KEY].append(object["key"]!)
            
        }else if object["itemType"] == ItemType.Email{
            emails[EMAIL_ADDRESS].append(object["object"]!)
            emails[EMAIL_TYPE].append(object["type"]!)
            emails[EMAIL_KEY].append(object["key"]!)

        }
        
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
