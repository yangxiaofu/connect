//
//  Info.swift
//  BConnect.To
//
//  Created by Dave Dong on 1/21/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation

class Info{
    private var _company:String = ""
    private var _headline:String = ""
    
    var company:String{
        get{
            return _company
        }
        set{
            _company = newValue
        }
    }
    var headline:String{
        get{
            return _headline
        }
        set{
            _headline = newValue
        }
    }
    
    
    init(){
        
    }
    //TODO: - Review to see if this is necessary
//    func updateCompany(company:String?) throws{
//        
//
//        
//        if let comp = company{
//            PFUser.currentUser()?[UserClass.company] = comp
//            PFUser.currentUser()?.saveInBackgroundWithBlock({ (succeeded, error ) -> Void in
//                if succeeded{
//                    print("Succeeded updating the company name")
//                }else{
//                    print("Error updaing company name")
//                }
//            })
//        }else{
//            throw UpdateCompanyError.InvalidCompanyName
//        }
//    }
//    
//    func updateHeadline(headline:String?) throws{
//        if let head = headline{
//            PFUser.currentUser()?[UserClass.headline] = head
//            PFUser.currentUser()?.saveInBackgroundWithBlock({ (succeeded, error ) -> Void in
//                if succeeded{
//                    print("Succeeded updating this information")
//                }else{
//                    print(error)
//                }
//            })
//        }else{
//            throw UpdateHeadlineError.InvalidHeadline
//        }
//    }
}
