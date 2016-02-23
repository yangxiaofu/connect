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
let USERID = "userId"

//MARK: - Keys
let KEY_UID = "uid"

//MARK: - Array Indices
let PHONE_NUMBER = 0
let PHONE_TYPE = 1
let PHONE_KEY = 2

let EMAIL_ADDRESS = 0
let EMAIL_TYPE = 1
let EMAIL_KEY = 2

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

struct Users{
    static let FullName = "full_name"
    static let Email = "email"
    static let Company = "company"
    static let Headline = "headline"
    static let FirstName = "first_name"
    static let LastName = "last_name"
    static let MiddleName = "middle_name"
    static let PhoneNumber = "phone_number"
}

struct Email{
    static let BranchName = "Email"
    static let Email = "email"
    static let UserId = USERID
    static let MyType = "type"
    static let Key = "key"
}

struct Phone{
    static let BranchName = "Phone"
    static let Number = "number"
    static let MyType = "type"
    static let Key = "key"
    static let UserId = USERID
}

struct Card{
    static let Id = "Id"
    static let BranchName = "Card"
    static let Name = "Name"
    static let Company = "Company"
    static let Headline = "Headline"
    static let Email = "Email"
    static let PhoneNumber = "PhoneNumber"
}



struct ItemType{
    static let Phone = "phone"
    static let Email = "email"
}