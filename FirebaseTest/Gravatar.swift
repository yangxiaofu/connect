//
//  Gravatar.swift
//  BConnectTo
//
//  Created by Dave Dong on 3/5/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation


class Gravatar{
    static let service = Gravatar()
    
    func getGravatarImage(email:String, completion:(data:NSData?, response:NSURLResponse?, error:NSError?) -> ()){
        //First trim the email
        let GRAVATAR_BASE_URL = "http://gravatar.com/avatar"
        
        let trimmedEmail = email.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        let imageUrl = "\(GRAVATAR_BASE_URL)/\(trimmedEmail.md5)"
        
        let NSImageUrl = NSURL(string: imageUrl)
        
        getDataFromUrl(NSImageUrl!) { (data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                guard let data = data where error == nil else { return }

                completion(data: data, response: response, error: error)
            })
            
        }
        
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }

}