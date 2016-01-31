//
//  BCardViewController.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/30/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit

class BCardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Storyboard
    struct Storyboard{
        static let EditBusinessCard = "EditBusinessCard"
    }
    
    //MARK: - @IbActions

    @IBAction func editBusinessCard(sender: AnyObject) {
        performSegueWithIdentifier(Storyboard.EditBusinessCard, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: - TableView Datasource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCard", forIndexPath: indexPath) as! BCardTableViewCell
            
            cell.company.text = "Test Comp"
            cell.headline.text = "Director Title"
            cell.name.text = "David Dong"
            cell.email.text = "fudaviddong@gmail.com"
            cell.number.text = "510-111-1111"
            
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCard", forIndexPath: indexPath) as! BCardTableViewCell
            
            cell.company.text = "Test Comp"
            cell.headline.text = "Director Title"
            cell.name.text = "David Dong"
            cell.email.text = "fudaviddong@gmail.com"
            cell.number.text = "510-111-1111"
            
            return cell

        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    //MARK: - TableView Delegates
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
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
