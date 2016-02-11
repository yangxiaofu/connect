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

struct ItemType{
    static let Phone = "phone"
    static let Email = "email"
}

enum PhoneType{
    case Personal
    case Work
    case Fax
    case Other
}

enum EmailType{
    case Personal
    case Work
    case Other
}


struct ConnectionClass{
    static let ClassName = "Connections"
    static let From = "From"
    static let To = "To"
    static let Location = "Location"
}

struct BusinessCardClass{
    static let ClassName = "BusinessCards"
    static let FullName = "FullName"
    static let Email = "Email"
    static let Phone = "Phone"
    static let Company = "Company"
    static let Headline = "Headline"
    static let UserImage = "UserImage"
    static let ObjectId = "objectId"
    static let Owner = "owner"
    static let UserId = "userId"
}

struct PhoneClass{
    static let ClassName = "PhoneNumbers"
    static let Number = "number"
    static let Type = "type"
    static let ObjectId = "objectId"
    static let UserId = "userId"
}

struct EmailClass{
    static let ClassName = "Emails"
    static let Email = "email"
    static let Type = "type"
    static let ObjectId = "objectId"
    static let UserId = "userId"
}

struct UserClass{
    static let className = "User"
    static let email = "email"
    static let objectId = "objectId"
    static let username = "username"
    static let firstName = "firstName"
    static let middleName = "middleName"
    static let lastName = "lastName"
    static let isNew = "isNew"
    static let company = "company"
    static let headline = "headline"
    static let primaryNumber = "primaryNumber"
    static let primaryEmail = "primaryEmail"
    
    static let myUsername = "myUsername"
    
    static let workEmail = "workEmail"
    static let personalEmail = "personalEmail"
    static let otherEmail = "otherEmail"
    static let mainEmail = "mainEmail"
    
    
    static let workNumber = "workNumber"
    static let personalNumber = "personalNumber"
    static let otherNumber = "otherNumber"
    static let faxNumber = "faxNumber"
    
    static let UserImage = "UserImage"
}