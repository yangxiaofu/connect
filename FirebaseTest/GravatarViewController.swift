//
//  GravatarViewController.swift
//  BConnectTo
//
//  Created by Dave Dong on 3/6/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit

protocol UserUpdatedImage{
    func UserDidCloseUpdateImage()
}

class GravatarViewController: UIViewController {
    var delegate:UserUpdatedImage?
    
    @IBOutlet var closeModal: UIBarButtonItem!
    @IBOutlet var webView: UIWebView!
    
    @IBAction func closeModal(sender: AnyObject) {
        
        if delegate != nil{
            delegate?.UserDidCloseUpdateImage()
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    var URLPath = "http://en.gravatar.com/emails/"
    
    func displayAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler:  nil ))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func loadAddressURL(){
        let requestURL = NSURL(string: URLPath)
        let request = NSURLRequest(URL: requestURL!)
        webView.loadRequest(request)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAddressURL()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        let message = "BConnect lets you change your profile image through gravatar.com and will be redirecting you to this website to update your profile image."
        
        displayAlert("", message: message)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
