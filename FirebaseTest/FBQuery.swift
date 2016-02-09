//
//  FBQuery.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/31/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

class FBQuery:FBObject{
    private var _URL_BASE_CLASSNAME_ID:String?
    private var _branchName:String?
    private var _userId:String?
    private var _id:String?
    
    //MARK: - Getters and Setters
    
    var URL_BASE_CLASSNAME_ID:String{
        get{
            return self._URL_BASE_CLASSNAME_ID!
        }
    }
    
    var branchName:String{
        get{
            return self._branchName!
        }
        set{
            self._branchName = newValue
        }
    }
    
    override init(className className:String){
        super.init(className: className)
        
        self.className = className
        
        URL_BASE_CLASSNAME = "\(URL_BASE)/\(className)"
    }

    func getObjectInBackgroundWithId(id:String, completionWithBlock:(object: AnyObject, error:String ) -> ()){
        _URL_BASE_CLASSNAME_ID  = "\(URL_BASE_CLASSNAME)/\(id)"
        var ref = Firebase(url: self._URL_BASE_CLASSNAME_ID)
        
        ref.observeSingleEventOfType(.Value, withBlock: { (snapshot) -> Void in
            completionWithBlock(object: snapshot.value, error: "")
        })
            
        { (error ) -> Void in
            print(error)
            completionWithBlock(object: "", error: "There was an error")
        
        }
    }
    
    func atBranch(branchName branchName:String){
        self._branchName = branchName
    }

    func getObjectsAtBranchWithinIdWithBlock(id:String, completionWithBlock:(objects: NSDictionary, error:String) -> ()){
        var errorString:String?
        var errorArray = [String]()
        var URL_BASE_CLASSNAME_ID_BRANCH:String!
        var myBranchName:String!
        
        if let b = self._branchName{
                myBranchName = b
                
                URL_BASE_CLASSNAME_ID_BRANCH = "\(URL_BASE_CLASSNAME)/\(id)/\(myBranchName)"
                let ref = Firebase(url: "\(URL_BASE_CLASSNAME_ID_BRANCH)")

                ref.observeSingleEventOfType(.Value, withBlock: { snapshot in
                    if let d = snapshot.value{
                        var dictionary = d as! NSDictionary
                        completionWithBlock(objects: dictionary, error: "")
                    }else{
                        completionWithBlock(objects: ["":""], error: "There were not objects in this path")
                    }

                })
        }else{
            completionWithBlock(objects: ["":""], error: "Branch name did not exist")
        }
    }
}