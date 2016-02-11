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
    var firstName = ""
    var lastName = ""
    var middleName = ""
    var fullName = ""
    var company = ""
    var headline = ""
    var test = ""
    var userImage:UIImage?
    var delegate:UserSavedInformationDelegate?
    var selectedCell:Int?
    var selectedSection:Int?
    
    @IBOutlet var tblView: UITableView!
    
    struct Storyboard{
        static let SelectImage = "selectImage"
    }
    struct SectionIdentifier{
        static let Phone = "Phone"
        static let Email = "Email"
    }
    
    //MARK: Save BCard
    
    @IBAction func closeModal(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveBCard(sender: AnyObject) {
//TODO: - Update the user class
//        user.businessCard.company = company
//        user.businessCard.headline = headline
//        user.businessCard.fullName = fullName
        
        //TODO: - DELETE THIS LINE OF CODE, I DO NOT THINK THI SIS VALUABLE RIGHT NOW.
        //        do{
        //            try user.info?.updateCompany(company)
        //            //TODO: - IS THIS REDUNDANT?
        //            user.info?.company = company
        //        }catch{
        //            print("the company name was an empty string")
        //        }
        //
        //        do{
        //            try user.info?.updateHeadline(headline)
        //            //TODO: - IS THIS REDUNDANT?
        //            user.info?.headline = headline
        //
        //        }catch{
        //            print("The headline was an empty string")
        //        }
        
        var fullNameDict = Dictionary<String, String>()
        //TODO: - UPdate the user class
//        fullNameDict = user.name.separateNameAsDictionary(fullName) as! Dictionary<String, String>
        
        if let fn = fullNameDict["firstName"]{
            firstName = fn
        }
        if let mn = fullNameDict["middleName"]{
            middleName = mn
        }
        if let ln = fullNameDict["lastName"]{
            lastName = ln
        }
        //TODO: - Update the user class
//        user.name.updateName(firstName, middleName: middleName, lastName: lastName)
//        if delegate != nil{
//            
//            
//            user.name.fullName = fullName
//            
//            user.businessCard.updateBusinessCard(user.businessCard.objectId, completion: { (success, error) -> () in
//                if success{
//                    
//                    self.delegate?.UserDidSaveInfo()
//                    
//                    self.dismissViewControllerAnimated(true, completion: nil)
//                    
//                }else{
//                    print(error)
//                }
//            })
//        }
    }
    
    @IBAction func selectImage(sender: AnyObject) {
        performSegueWithIdentifier(Storyboard.SelectImage, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: - Update the user Image class
//        user.userImage?.getImageFromParse({ (image) -> () in
//            self.userImage = image
//        })
        
        // Do any additional setup after loading the view.
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
            print(company)
            
        case 2: //FULLNAME
            if let fn = textField.text{
                fullName = fn
            }
            print(fullName)
        case 3: //HEAD
            if let head = textField.text{
                headline = head
            }
            print(headline)
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
            
            cell.userImage.image = userImage
                //TODO: - Update the user class
//            cell.company.text = user.info?.company
//            company = (user.info?.company)!
//            cell.company.delegate = self
//            
//            cell.headline.text = user.info?.headline
//            headline = (user.info?.headline)!
//            cell.headline.delegate = self
//            
//            cell.fullName.text = user.name.fullName
//            fullName = user.name.fullName
//            cell.fullName.delegate = self
            
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
                //TODO: - Update the user class
//            cell.textLabel?.text = user.numbers?.phoneNumbers[indexPath.row]
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
            //TODO: - Update the user class
//             cell.textLabel?.text = user.email.emails[indexPath.row]
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
            //TODO: - Update the user numbers class
            return 1
//            return (user.numbers?.phoneNumbers.count)!
        case 2: //Email
            //TODO: - Update the user email class
            return 1
//            return user.email.emails.count
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
