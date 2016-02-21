//
//  DDBusinessCard.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/30/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation



class DDBusinessCard:FBQuery{
   
    struct Card{
        static let Name = "name"
        static let Company = "company"
        static let Headline = "headline"
        static let Email = "email"
        static let PhoneNumber = "phoneNumber"
    }
    
    private var _name:String!
    
    private var _company:String!
    
    private var _headline:String?
    
    private var _email:String?
    
    private var _phoneNumber:String?
    
    var name:String{
        return self._name
    }
    
    var company:String{
        return self._company
    }
    
    var email:String{
        return self._email!
    }
    
    var headline:String{
        return self._headline!
    }
    
    var phoneNumber:String{
        return self._phoneNumber!
    }
    
    var card:Dictionary<String, AnyObject>{
        get{
            return self.dictionary
        }
    }
    
    override subscript(key: String) -> AnyObject{
        get{
            return self.dictionary[key]!
        }
        set{
            self.dictionary[key] = newValue
        }
    }
    
    //MARK: - Initializers

    init(){
        super.init(className: "BusinessCards")
    }
    
    init(name:String, company:String, headline:String){
        super.init(className: "BusinessCards")
        self._name = name
        self._company = company
        self._headline = headline
    }
}