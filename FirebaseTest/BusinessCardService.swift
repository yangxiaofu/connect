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
    
    var REF_CARD:Firebase{
        get{
            return _REF_CARD
        }
    }
    
    func createFirebaseCard(uid:String, var card:Dictionary<String, String>){
        card["owner_unique_id"] = uid
        let cardReference = REF_CARD.childByAutoId()
        cardReference.setValue(card)
        

        let card_id:String = cardReference.key
        print(card_id)
        
        let card_ref = [
            "unique_id": card_id
        ]
        
        let userReference = REF_USERS.childByAppendingPath(card_id)
        
        userReference.setValue(card_ref)
        
    }
}