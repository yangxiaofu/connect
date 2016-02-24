//
//  BusinessCardService.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/31/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

class BusinessCard:DataService{
    
    static let card = BusinessCard()
    
    private var _REF_CARD = Firebase(url: "\(URL_BASE)/cards")
    
    private var _REF_USERS_CARD = Firebase(url: "\(URL_BASE)/users/\(ds.uniqueUserId)/cards")
    
    var REF_CARD:Firebase{
        get{
            return _REF_CARD
        }
    }
    
    var REF_USERS_CARD:Firebase{
        get{
            return _REF_USERS_CARD
        }
    }
    
    func createFirebaseCard(uid:String, var card:Dictionary<String, String>){
        
        card["owner_unique_id"] = uid
        let cardReference = REF_CARD.childByAutoId()
        cardReference.setValue(card)
        
        let card_id:String = cardReference.key
        
        let card_ref = [
            card_id: true
        ]
        
        REF_USERS_CARD.setValue(card_ref)
    }
    
    func updateFirebaseCard(card_unique_id:String, card:Dictionary<String, String>){
        let specificCardRef = REF_CARD.childByAppendingPath(card_unique_id)
        specificCardRef.updateChildValues(card)
    }
    
    func removeFirebaseCard(card_unique_id:String){
        
    }
    
    
}