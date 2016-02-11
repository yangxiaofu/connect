//
//  SelectImageTableViewController.swift
//  BConnect.To
//
//  Created by Dave Dong on 1/22/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

protocol SavedUserImageDelegate{
    func UserDidSaveUserImage(image:UIImage)
}

class SelectImageTableViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var delegate:SavedUserImageDelegate?
    
    @IBOutlet var imageToPost: UIImageView!
    
    @IBAction func closeModal(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func selectImage(sender: AnyObject) {
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    //MARK: - DELEGATES
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        imageToPost.image = image
    }
    
    @IBAction func postImage(sender: AnyObject) {
        
        let imageData = UIImageJPEGRepresentation(imageToPost.image!, 0.3)
        //TODO: - Update the user class
////        user.userImage?.saveImageToParse(imageData!, completion: { (success, error) -> () in
//            if success == true{
//                user.userImage?.image = self.imageToPost.image
//                self.delegate?.UserDidSaveUserImage(self.imageToPost.image!)
//                
//                self.dismissViewControllerAnimated(true, completion: nil)
//                
//            }else{
//                print("There was a problem saving this image.  SelectImageTableViewcontroller")
//            }
//        })
        
        
        
        
        //Save to Parse
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UPDATE THE USER CLASS AND UPDATE THE USER IMAGE IFNORMATION
//        user.userImage?.getImageFromParse({ (image) -> () in
//            self.imageToPost.image = image
//        })
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
