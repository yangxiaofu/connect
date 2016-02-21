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

class EditBCardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, SavedUserImageDelegate{
    var fullName = ""
    var company = ""
    var headline = ""
    var test = ""
    var userImage:UIImage?
    var delegate:UserSavedInformationDelegate?
    var selectedCell:Int?
    var selectedSection:Int?
    var name:DDNameString?
    
    
    @IBOutlet var tblView: UITableView!
    
    struct Storyboard{
        static let SelectImage = "selectImage"
    }
    struct SectionIdentifier{
        static let Phone = "Phone"
        static let Email = "Email"
    }
    
    @IBAction func closeModal(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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
                self.dismissViewControllerAnimated(true, completion: nil)
            }else{
                let alert = UIAlertController(title: "", message: error, preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    
    }
    
    @IBAction func selectImage(sender: AnyObject) {
        performSegueWithIdentifier(Storyboard.SelectImage, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {

        if let _company = snapshot?.value[Users.Company]{
            if let _comp = _company{
                print(_comp)
                company = _comp as! String
            }else{
                company = ""
            }
        }else{
            company = ""
        }
        
        if let _headline = snapshot?.value[Users.Headline]{
            if let _head = _headline{
                headline = _head as! String
            }else{
                headline = ""
            }
        }else{
            headline = ""
        }
        
        if let _fullName = snapshot?.value[Users.FullName]{
            if let _full = _fullName{
                fullName = _fullName as! String
            }else{
                fullName = ""
            }
            
        }else{
            
            fullName = ""
            
        }
        
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
            //FIXME: - PROBLEM WITH THE TEXT FIELD RETURN SO THAT TEH SAVE METHOD CAN SAVE THE CORRECT INFORMATION
            
            cell.userImage.image = UIImage(data: user.userImageData)
            
            cell.company.text = company
            cell.company.delegate = self
            
            cell.headline.text = headline
            cell.headline.delegate = self
            
            cell.fullName.text = fullName
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
//        switch indexPath.section{
////        case 1: //Phones
////            //TODO: - UPdate the user class
////
//////            user.businessCard.phoneNumber = (user.numbers?.phoneNumbers[indexPath.row])!
////        case 2: //Emails
////            
//////            user.businessCard.email = user.email.emails[indexPath.row]
////        default:
////            break
////        }
        tblView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor.redColor()
        header.textLabel?.textColor = UIColor.whiteColor()
        header.alpha = 0.5
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func UserDidSaveUserImage(image: UIImage) {
        self.userImage = image
        self.tblView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.SelectImage{
            let selectImageVC:SelectImageTableViewController = segue.destinationViewController as! SelectImageTableViewController
            selectImageVC.delegate = self
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
