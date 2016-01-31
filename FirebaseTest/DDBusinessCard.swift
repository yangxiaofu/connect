//
//  DDBusinessCard.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/30/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation



class DDBusinessCard{
    
    
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
    
    private var _card:Dictionary<String, String>!
    
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
    
    var card:Dictionary<String, String>{
        get{
            return self._card!
        }

    }
    
    //MARK: - Initializers
    init(){
        
    }
    
    init(name:String, company:String, headline:String){
        self._name = name
        self._company = company
        self._headline = headline
    }
}