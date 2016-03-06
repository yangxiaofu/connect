//
//  ContactsViewTableViewController.swift
//  BConnectTo
//
//  Created by Dave Dong on 2/24/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit

class ContactsViewTableViewController: UITableViewController {
    
    struct Storyboard{
        static let ShowDetails = "showDetails"
        static let Logout = "logout"
    }
    
    var contactEmails = [String]()
    var contactCompany = [String]()
    var contactNames = [String]()
    var contactUserId = [String]()
    var cardId = [String]()

    
    @IBAction func logout(sender: AnyObject) {
        user.logOut()
        performSegueWithIdentifier(Storyboard.Logout, sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Contacts"
        
        if let e = connections?.email{
            contactEmails = e
        }
        
        if let c = connections?.company{
            contactCompany = c
        }
        
        if let n = connections?.names{
            contactNames = n
        }
        
        if let u = connections?.theOtherUserId{
            contactUserId = u
        }
        
        if let ck = connections?.cardId{
            cardId = ck
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactEmails.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("contactRow", forIndexPath: indexPath) as!
ContactCellTableViewCell
        
        Gravatar.service.getGravatarImage(contactEmails[indexPath.row]) { (data, response, error) -> () in
            cell.userImage.image = UIImage(data: data!)
        }
    
        cell.fullName.text = contactNames[indexPath.row]
        cell.headline.text = contactCompany[indexPath.row]

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let height:CGFloat = 100.0
        
        return height
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(Storyboard.ShowDetails, sender: cardId[indexPath.row])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var theUserId:String
        
        if segue.identifier == Storyboard.ShowDetails{
            let contactDetailsVC:ContactDetailsViewController = segue.destinationViewController as! ContactDetailsViewController

            if let c = sender{
                contactDetailsVC.cardId = c as! String
            }
            

        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
