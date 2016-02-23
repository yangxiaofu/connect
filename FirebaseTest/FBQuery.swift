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
    
    var arrayOfObjects = [[String]]()
    
    
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

    func getObjectsAtBranchWithinIdWithBlock(branchName:String, id:String, completionWithBlock:(objects: FDataSnapshot) -> ()){
        let URL_REF = "\(URL_BASE)/\(branchName)/\(id)"
        let ref = Firebase(url: URL_REF)
        
        ref.observeEventType(.Value) { (snapshot) -> Void in
            completionWithBlock(objects: snapshot)
        }
    }
    
    func getArrayOf(userId:String) -> Void{
        var arrayOfObject = [String]()
        var arrayOfType = [String]()
        var arrayOfKey = [String]()
        
        
        var keys = [String]()
        let url  = "\(URL_BASE)/Users/\(userId)/\(self.className)"
        let ref = Firebase(url: url)
        
        ref.observeEventType(.Value, withBlock: { (snapshot) -> Void in

            for i in snapshot.children{
                let item = i as! FDataSnapshot
                keys.append(item.key)
            }
            if keys.count != 0{
                for x in keys{
                    
                    
                    var url_key = "\(URL_BASE)/\(self.className)/\(x)"
                    var refkey = Firebase(url: url_key)
                    
                    arrayOfKey.append(x as! String)
                    refkey.observeSingleEventOfType(.Value, withBlock: { (snapshot2) -> Void in
                        
                        if self.className == Email.BranchName{
                            if let e = snapshot2.value[Email.Email]{
                                if let et = snapshot2.value["type"]{
                                    arrayOfObject.append(e as! String)
                                    arrayOfType.append(et as! String)
                                }
                            }
                        } else if self.className == Phone.BranchName{
                            if let pn = snapshot2.value[Phone.Number]{
                                if let pt = snapshot2.value["type"]{
                                    arrayOfObject.append(pn as! String)
                                    arrayOfType.append(pt as! String)
                                }
                            }
                        } 
                        self.arrayOfObjects = [arrayOfObject, arrayOfType, arrayOfKey]
                        
                    })
                }

            }else{
                self.arrayOfObjects = [[], [], []]
            }
            
        }) { (error) -> Void in
            print (error)
        }
    }
    
    
}