//
//  EditBCardViewController.swift
//  BConnect.To
//
//  Created by Dave Dong on 1/18/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

protocol UserSavedInformationDelegate{
    func UserDidSaveInfo()
}

class EditBCardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UserUpdatedImage{
    private var fullName = ""
    private var company = ""
    private var headline = ""
    private var test = ""
    private var selectedPhoneNumber = ""
    private var selectedEmail = ""
    var userImage:UIImage?
    var delegate:UserSavedInformationDelegate?
    var selectedCell:Int?
    var selectedSection:Int?
    var name:DDNameString?
    
    @IBOutlet var tblView: UITableView!
    
    struct Storyboard{
        static let Gravatar = "toGravatar"
    }
    struct SectionIdentifier{
        static let Phone = "Phone"
        static let Email = "Email"
    }
    
    @IBAction func closeModal(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func displayAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveBCard(sender: AnyObject) {
         //TODO: - Complete the save user feature
        
        let saveUser = FBUser()
        saveUser.objectId = user.objectId
        if company != ""{
            saveUser[Users.Company] = company
        }
        
        saveUser[Users.FullName] = fullName
        saveUser[Users.Headline] = headline
        saveUser.saveInBackgroundWithBlock { (success, error) -> () in
         
            if success {
                
                card.name = self.fullName
                
                card.company = self.company
                
                card.headline = self.headline
                
                card.phoneNumber = self.selectedPhoneNumber
                
                card.email = self.selectedEmail
                
                card.updateCard()
                
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    self.delegate?.UserDidSaveInfo()
                })
                
            }else{
                self.displayAlert("", message: error)
            }
        }
    }
    
    @IBAction func selectImage(sender: AnyObject) {
        performSegueWithIdentifier(Storyboard.Gravatar, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        company = card.company
        fullName = card.name
        headline = card.headline
        selectedPhoneNumber = card.phoneNumber
        selectedEmail = card.email
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        
        switch textField.tag{
            
        case 1: //COMPANY
            if let comp = textField.text{
                company = comp
            }
            
        case 2: //FULLNAME
            
            if let fn = textField.text{
                fullName = fn
            }
            
        case 3: //HEAD
            
            if let head = textField.text{
                headline = head
            }
            
        default:
            break
        }
        
        return true
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0: //Info
            let cell = tableView.dequeueReusableCellWithIdentifier("InfoCell", forIndexPath: indexPath) as! EditInfoTableViewCell
            
            Gravatar.service.getGravatarImage(user.email, completion: { (data, response, error) -> () in
                cell.userImage.image = UIImage(data: data!)
            })
            
            cell.company.text = card.company
            cell.company.delegate = self
            
            cell.headline.text = card.headline
            cell.headline.delegate = self
            
            cell.fullName.text = card.name
            cell.fullName.delegate = self
            
            return cell
        case 1: //Phone
            let cell = tableView.dequeueReusableCellWithIdentifier("PhoneCell", forIndexPath: indexPath)
            
            if indexPath.section == selectedSection{
                if indexPath.row == selectedCell{
                    
                    cell.accessoryType = .Checkmark
                    cell.selected = true
                }else{
                    cell.accessoryType = .None
                    cell.selected = false
                }
            }
            
            cell.textLabel?.text = phoneNumbers[PHONE_NUMBER][indexPath.row]
            
            return cell
        case 2: //Email
            let cell = tableView.dequeueReusableCellWithIdentifier("EmailCell", forIndexPath: indexPath)
            if indexPath.section == selectedSection{
                if indexPath.row == selectedCell{
                    cell.accessoryType = .Checkmark
                    cell.selected = true
                }else{
                    cell.accessoryType = .None
                    cell.selected = false
                }
                
            }
            
            cell.textLabel?.text = emails[EMAIL_ADDRESS][indexPath.row]
            
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("InfoCell", forIndexPath: indexPath)
            
            cell.textLabel?.text = "Cell"
            
            return cell
            
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section{
        case 0: //Info
            return 1
        case 1: //Phone
            return phoneNumbers[PHONE_NUMBER].count
        case 2: //Email
            return emails[EMAIL_ADDRESS].count
        default:
            return 1
        }
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height:CGFloat = 50.0
        
        switch indexPath.section{
        case 0:
            height = 361.0
        case 1, 2:
            height = 50.0
        default:
            height = 50.0
        }
        
        return height
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section{
        case 0: //BCard Info
            return "Business Card Information"
        case 1: //Phone
            return "Select Phone Number To Display"
        case 2: //Email
            return "Select Email To Display"
        default:
            return ""
        }
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section{
        case 1,2:
            return 25
        default:
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedCell = indexPath.row
        selectedSection = indexPath.section
        
        switch indexPath.section{
            
        case 1: //Phones
            selectedPhoneNumber = phoneNumbers[PHONE_NUMBER][indexPath.row]
        case 2: //Emails
            selectedEmail = emails[EMAIL_ADDRESS][indexPath.row]
        default:
            break
        }
        tblView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Helvetica", size: 15.0)
        
        switch section{
            
        case 1:
            header.contentView.backgroundColor = UIColor(red: 0/255, green: 171/255, blue: 175/255, alpha: 1.0)
            header.textLabel?.textColor = UIColor.whiteColor()
            header.alpha = 0.5
            
        case 2:
            
            header.contentView.backgroundColor = UIColor(red: 239/255, green: 81/255, blue: 82/255, alpha: 1.0)
            header.textLabel?.textColor = UIColor.whiteColor()
            header.alpha = 0.5

        default:
            header.contentView.backgroundColor = UIColor(red: 0/255, green: 171/255, blue: 175/255, alpha: 1.0)
            header.textLabel?.textColor = UIColor.whiteColor()
            header.alpha = 0.5

            
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func UserDidCloseUpdateImage() {
        print("Closed teh image and user has it updated")
        self.tblView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.Gravatar{
            let gravatarVC:GravatarViewController = segue.destinationViewController as! GravatarViewController
            gravatarVC.delegate = self
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
