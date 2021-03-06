//
//  DDBusinessCard.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/30/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

class DDBusinessCard:FBQuery{
    private var _my_card_url:String = ""
    private var _card_url:String = ""
    private var _userId:String = ""
    private var _cardId:String!
    private var _name:String!
    private var _company:String!
    private var _headline:String?
    private var _email:String?
    private var _phoneNumber:String?
    private var _cardToSend:Dictionary<String, AnyObject>!
    
    var cardId:String{
        get{
            if let id = self._cardId{
                return id
            }else{
                return ""
            }
        }
        
        set{
            self._cardId = newValue
        }
        
    }
    
    var name:String{
        get{
            if let n = self._name{
                return n
            }else{
                return ""
            }

        }
        set{
            self._name = newValue
        }
    }
    
    var company:String{
        get{
            if let c = self._company{
                return c
            }else{
                return ""
            }
        }
        set{
            self._company = newValue
        }
    }
    
    var email:String{
        get{
            if let e = self._email{
                return e
            }else{
                return ""
            }
        }
        set{
            self._email = newValue
        }
    }
    
    var headline:String{
        get{
            if let h = self._headline{
                return h
            }else{
                return ""
            }
        }
        set{
            self._headline = newValue
        }
        
    }
    
    var phoneNumber:String{
        get{
            if let ph = self._phoneNumber{
                return ph
            }else{
                return ""
            }
        }
        set{
            self._phoneNumber = newValue
        }
        
        
    }
    
    var card:Dictionary<String, AnyObject>{
        get{
            return self.dictionary
        }
    }
    
    var transferCard:Dictionary<String, AnyObject>{
        get{
            return self._cardToSend!
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
    
    init(name:String, company:String, headline:String, phoneNumber:String, email:String){
        super.init(className: "BusinessCards")
        
        self._userId = user.objectId
        self._name = name
        self._company = company
        self._headline = headline
        self._phoneNumber = phoneNumber
        self._email = email
    }
    
    init(id:String){
        super.init(className: "BusinessCards")
        
        self._userId = user.objectId
        let url = "\(URL_BASE)/\(Card.BranchName)/\(id)"
        let ref = Firebase(url: url)
        
        ref.observeSingleEventOfType(.Value, withBlock: { (cardSnapshot) -> Void in
            let card = cardSnapshot.value
            
            if let c = card[Card.Company]{
                if c != nil{
                    self._company = c as! String
                }else{
                    self._company = ""
                }
            }
            
            if let e = card[Card.Email]{
                if e != nil{
                    self._email = e as! String
                }else{
                    self._email = ""
                }
            }
            
            if let h = card[Card.Headline]{
                if h != nil{
                    self._headline = h as! String
                }else{
                    self._headline = ""
                }
                
            }
            
            if let n = card[Card.Name]{
                if n != nil{
                    self._name = n as! String
                }else{
                    self._name = ""
                }
                
            }
            
            if let pn = card[Card.PhoneNumber]{
                if pn != nil{
                    self._phoneNumber = pn as! String
                }else{
                    self._phoneNumber = ""
                }
                
            }
            
            if let uId = card["userId"]{
                if uId != nil{
                    self._userId = uId as! String
                }else{
                    self._userId = ""
                }
                
            }
            print("Inside the DDBUSINESSCARD CLASS")
            print(self._name)
            
        }) { (error ) -> Void in
            print("There was an error getting the card")
        }
    }
    
    init(userId:String){
        super.init(className: "BusinessCards")
        
        self._userId = userId
        self._card_url = "\(URL_BASE)/Users/\(userId)/Card"
        
        let ref = Firebase(url: self._card_url)
        ref.observeEventType(.Value, withBlock: { (snapshot) -> Void in
            
            for i in snapshot.children{
                
                let item = i as! FDataSnapshot
                self._my_card_url = "\(URL_BASE)/Card/\(item.key)"
                self._cardId = item.key
                
                let card_ref = Firebase(url: self._my_card_url)
                card_ref.observeSingleEventOfType(.Value, withBlock: { (snapshot2) -> Void in
                    self.cardId = item.key
                    if let name = snapshot2.value[Card.Name]{
                        if let n = name{
                            self._name = n as! String
                        }else{
                            self._name = ""
                        }
                    }
                    
                    if let comp = snapshot2.value[Card.Company]{
                        if let c = comp{
                            self._company = c as! String
                        }else{
                            self._company = ""
                        }
                    }
                    
                    if let head = snapshot2.value[Card.Headline]{
                        if let h = head{
                            self._headline = head as! String
                        }else{
                            self._headline = ""
                        }
                    }
                    
                    if let ph = snapshot2.value[Card.PhoneNumber]{
                        if let p = ph{
                            self._phoneNumber = ph as! String
                        }else{
                            self._phoneNumber = ""
                        }
                        
                    }
                    
                    if let e = snapshot2.value[Card.Email]{
                        if let _e = e{
                            self._email = e as! String
                        }else{
                            self._email = ""
                        }
                    }
                    
                }, withCancelBlock: { (error) -> Void in
                    print(error)
                })
            }
        }) { (error ) -> Void in
            print(error)
        }
    }
    func updateCard() -> Void{

        let card_url = "\(URL_BASE)/Card/\(self.cardId)"
        let card_ref = Firebase(url: "\(card_url)")
        
        let saveDictionary = [
            Card.Name: self._name,
            Card.Company: self._company,
            Card.Headline: self._headline,
            Card.PhoneNumber: self._phoneNumber,
            Card.Email: self._email
        ]
        
        card_ref.updateChildValues(saveDictionary)
    }
    
    func prepareToSend(){
        struct CardToSend{
            static let CardId = "cardId"
            static let Name = "name"
            static let Company = "company"
            static let Headline = "headline"
            static let Email = "email"
            static let PhoneNumber = "phoneNumber"
            static let UserId = "userId"
        }
        
        self._cardToSend = [
            CardToSend.CardId: self.cardId,
            CardToSend.Name: self.name,
            CardToSend.Headline:self.headline,
            CardToSend.Company:self.company,
            CardToSend.Email:self.email,
            CardToSend.PhoneNumber:self.phoneNumber,
            CardToSend.UserId:user.objectId
        ]
        print(self.transferCard)
        
    }
    
}