//
//  Constants.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/30/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

//MARK: - URLs
let URL_BASE = "https://bconnectto.firebaseio.com"

//MARK: - Keys
let KEY_UID = "uid"

//MARK: - Segues
struct Storyboard {
    static let SignedUp = "SignedUp"
    static let LoggedIn = "LoggedIn"
}

//MARK: - Error Codes
let ERROR_CODE_EMAIL_TAKEN = -9
let ERROR_CODE_INVALID_PASSWORD = -6
let ERROR_CODE_FIREBASE_AUTHENTICATION = -16
let ERROR_CODE_INVALID_USER = -8
let ERROR_CODE_INVALID_EMAIL = -5

//MARK: - Data Structures within Firebase

struct User {
    static let FullName = "full_name"
    static let Email = "email"
}

struct Card{
    static let OwnerUniqueID = "owner_unique_id"
    static let UniqueID = "unique_id"
    static let Company = "company"
    static let Email = "email"
    static let Name = "name"
    static let Headline = "headline"
}

struct Email{
    static let OwnerUniqueID = "owner_unique_id"
    static let UniqueID = "unique_id"
    static let Type = "type"
    static let Email = "email"
}

struct Phone{
    static let OwnerUniqueId = "owner_unique_id"
    static let UniqueId = "unique_id"
    static let Type = "type"
    static let Email = "email"
}