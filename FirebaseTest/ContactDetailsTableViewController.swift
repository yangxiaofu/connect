//
//  ContactDetailsTableViewController.swift
//  BConnectTo
//
//  Created by Dave Dong on 2/25/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cardId:String?
    var thisCardId = ""
    var thisCard:DDBusinessCard?
    var name = ""
    var company = ""
    var headline = ""
    var email = ""
    var phoneNumber = ""
    
    @IBOutlet var tblView: UITableView!
    
    
    @IBAction func closeModel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if let c = cardId{
            thisCardId = c
            thisCard = DDBusinessCard(id: thisCardId)
        }
        
        
        let delay = 1.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
    
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            if let e = self.thisCard?.email{
                self.email = e
            }
            
            if let c = self.thisCard?.company{
                self.company = c
            }
            
            if let n = self.thisCard?.name{
                self.name = n
            }
            
            if let h = self.thisCard?.headline{
                self.headline = h
            }
            
            if let pn = self.thisCard?.phoneNumber{
                self.phoneNumber = pn
            }
            
            self.tblView.reloadData()
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //TODO: - Activity Indicator
        let cell = tableView.dequeueReusableCellWithIdentifier("bcard", forIndexPath: indexPath) as! BCardTableViewCell
        
        Gravatar.service.getGravatarImage(self.email, completion: { (data, response, error) -> () in
            cell.userImage.image = UIImage(data: data!)
        })
        cell.name.text = self.name
        cell.company.text = self.company
        cell.headline.text = self.headline
        cell.email.text = self.email
        cell.phoneNumber.text = self.phoneNumber

        return cell
        
    
        
        // Configure the cell...


    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
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
