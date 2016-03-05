//
//  ShareViewController.swift
//  BConnect.To
//
//  Created by Dave Dong on 1/24/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import MultipeerConnectivity
import CoreLocation
import Contacts

class ShareViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MPCManagerDelegate, CLLocationManagerDelegate{
    
    struct Storyboard{
        static let Logout = "logout"
    }
    
    var mpcManager:MPCManager!
    var isAdvertising:Bool!
    var latitude:CLLocationDegrees?
    var longitude:CLLocationDegrees?
    var locationManager = CLLocationManager()
    var otherUserId:String = ""
    var businessCardObjectId:String = ""
    
    @IBOutlet var shareButtonLabel: UIButton!
    
    @IBOutlet var tblView: UITableView!
    
    //MARK: - @IBACTIONS
    
    @IBAction func logout(sender: AnyObject) {
        user.logOut()
        performSegueWithIdentifier(Storyboard.Logout, sender: self)
    }
    
    @IBAction func shareButton(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "", message: "Change Visibility", preferredStyle: .ActionSheet)
        
        var actionTitle: String
        
        if isAdvertising == true
        {
            actionTitle = "Make me invisible to others"
        }
        else
        {
            actionTitle = "Make me visible to others"
        }
        
        let visibilityAction:UIAlertAction = UIAlertAction(title: actionTitle, style: .Default) { (alertAction) -> Void in
            if self.isAdvertising == true{
                self.mpcManager.advertiser.stopAdvertisingPeer()
                self.isAdvertising = false
            }else{
                self.mpcManager.advertiser.startAdvertisingPeer()
                self.isAdvertising = true
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil )
        
        actionSheet.addAction(visibilityAction)
        actionSheet.addAction(cancelAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
        
    }
    
    func handleMPCReceivedDataWithNotification(notification: NSNotification){
        let receivedDataDictionary = notification.object as! Dictionary<String, AnyObject>
        
        let data = receivedDataDictionary["data"] as? NSData
        
        let dataDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! Dictionary<String, AnyObject  >
        
        if let oId = dataDictionary["userId"]{
            otherUserId = oId as! String
            print("other user id \(otherUserId)")
        }
        if let bCardoid = dataDictionary["objectId"]{
            businessCardObjectId = bCardoid as! String
            print("The business card object Id is \(businessCardObjectId)")
        }
        
        
        let delayInSeconds = 1.0
        let delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_MSEC)))
        let concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_after(delayInNanoSeconds, concurrentQueue, { () -> Void in
            self.makeConnection()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Invite Contacts"
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mpcManager = MPCManager()
        mpcManager.delegate = self
        
        mpcManager.browser.startBrowsingForPeers()
        
        mpcManager.advertiser.startAdvertisingPeer()
        isAdvertising = true
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleMPCReceivedDataWithNotification:", name: "receivedMPCDataNotification", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Peer", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = mpcManager.foundPeers[indexPath.row].displayName
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedPeer = mpcManager.foundPeers[indexPath.row] as MCPeerID
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        
        selectedCell?.accessoryType = .Checkmark
        
        let concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(concurrentQueue) { () -> Void in
            self.mpcManager.browser.invitePeer(selectedPeer, toSession: self.mpcManager.session, withContext: nil , timeout: 20)
        }
        
        let alert = UIAlertController(title: "", message: "You have requested a business card!", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil ))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mpcManager.foundPeers.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70.0
    }
    
    //MARK: - DELEGATE METHODS
    func foundPeer() {
        tblView.reloadData()
    }
    func lostPeer() {
        tblView.reloadData()
    }
    
    func invitationWasReceived(fromPeer: String) {
        let alert = UIAlertController(title: "", message: "\(fromPeer) wants to share their business card with you.", preferredStyle: .Alert)
        
        let acceptAction = UIAlertAction(title: "Accept", style: .Default) { (alertAction) -> Void in
            self.mpcManager.invitationHandler(true, self.mpcManager.session)
        }
        let declineAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil )
        
        alert.addAction(acceptAction)
        alert.addAction(declineAction)
        
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    func connectedWithPeer(peerId: MCPeerID) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            
            let concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            dispatch_async(concurrentQueue, { () -> Void in

                card.prepareToSend()

                self.mpcManager.sendData(dictionaryWithData: card.transferCard, toPeer: self.mpcManager.session.connectedPeers[0] as MCPeerID)
            })
        }
    }
    
    func didNotConnectWithPeer() {
        let alert = UIAlertController(title: "", message: "Your connection was not successfull.  Please try again.", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil ))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK: - Core Location Manager Delegate Methods
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0]
        
        latitude = userLocation.coordinate.latitude
        longitude = userLocation.coordinate.longitude
        
    }
    
    private func makeConnection(){
        var latString = 0.0
        var lonString = 0.0
        
        if let lat = latitude{
            latString = lat as! Double
        }
        
        if let lon = longitude{
            lonString = lon as! Double
        }
        
        let connectionObject = FBObject(className: Connections.BranchName)
    
        connectionObject.userId = user.objectId
        connectionObject[Connections.Latitude] = latString
        connectionObject[Connections.Longitude] = lonString
        connectionObject[Connections.OtherUserId] = otherUserId
        
        connectionObject.saveInBackgroundWithBlock { (success, error) -> () in
            if success {
                print("Making the connection was successful")
            }else{
                print("There was an error making this connection")
            }
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
