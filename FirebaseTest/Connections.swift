//
//  Connections.swift
//  BConnectTo
//
//  Created by Dave Dong on 2/27/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation
import CoreLocation

class FBConnections{
    
    struct Connections{
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let OtherUserId = "otherUserId"
        static let UserId = "userId"
    }
    //TODO: - Branchname
    private var _branchName:String!
    private var _userId:String!
    private var _id = [String]()
    private var _latitude = [CLLocationDegrees]()
    private var _longitude = [CLLocationDegrees]()
    private var _otherUserId = [String]()
    private var _user_url = ""
    private var _user_ref:Firebase!
    private var _names = [String]()
    private var _company = [String]()
    private var _email = [String]()
    private var _theOtherUserId = [String]()
    private var _cardId = [String]()
    
    var names:[String]{
        get{
            return self._names
        }
    }
    
    var cardId:[String]{
        get{
            return self._cardId
        }
    }
    
    var company:[String]{
        get{
            return self._company
        }
    }
    
    var email:[String]{
        get{
            return self._email
        }
    }
    
    var id:[String]{
        get{
            return self._id
        }
    }
    
    var theOtherUserId:[String]{
        get{
            return self._theOtherUserId
        }
    }
    
    var latitude:[CLLocationDegrees]{
        get{
            return self._latitude
        }
    }
    
    var longitude:[CLLocationDegrees]{
        get{
            return self._longitude
        }
    }
    
    var otherUserId:[String]{
        get{
            return self._otherUserId
        }
    }

    init(userId:String, branchName:String){
        self._userId = userId
        self._branchName = branchName
        _user_url = "\(URL_BASE)/Users/\(self._userId)/\(self._branchName)"
        _user_ref = Firebase(url: _user_url)
    }
    
    func prepareFriendsArray(){
        print(self._otherUserId)
        for x in self._otherUserId{
            print(x)
        }
    }
    
    func prepareArray(){
        var keys = [String]()
        
        self._user_ref.observeEventType(.Value, withBlock: { (snapshot) -> Void in
            
            for i in snapshot.children{
                let item = i as! FDataSnapshot
                keys.append(item.key)
            }
            
            if keys.count != 0{
                
                for x in keys{
                    let url_key = "\(URL_BASE)/\(self._branchName)/\(x)"
                    let refKey = Firebase(url: url_key)
                    
                    self._id.append(x)
                    
                    refKey.observeSingleEventOfType(.Value, withBlock: { (snapshot2) -> Void in
                        if let lat = snapshot2.value[Connections.Latitude]{
                            self._latitude.append((lat as! CLLocationDegrees?)!)
                        }
                        
                        if let lon = snapshot2.value[Connections.Longitude]{
                            self._longitude.append((lon as! CLLocationDegrees?)!)
                        }
                        
                        if let oUserId = snapshot2.value[Connections.OtherUserId]{
                            let oId = oUserId as! String
                            self._otherUserId.append(oId)
                            let thisUrl = "\(URL_BASE)/Connections/\(x)"

                            let thisRef = Firebase(url: thisUrl)
                            thisRef.observeEventType(.Value, withBlock: { (snapshot) -> Void in
                                let connectionsKey = snapshot.value

                                if let theOtherUser = connectionsKey["otherUserId"]{
                                    let userCardUrl = "\(URL_BASE)/Users/\(theOtherUser as! String)/Card"
                                    let userCardUrlFB = Firebase(url: userCardUrl)
                                    userCardUrlFB.observeSingleEventOfType(.Value, withBlock: { (userSnapshot) -> Void in
                                        for a in userSnapshot.children{
                                            let theCardKey = a as! FDataSnapshot
                                            let otherUserCardUrl = "\(URL_BASE)/Card/\(theCardKey.key)"
                                            let otherUserCardUrlFB = Firebase(url: otherUserCardUrl)

                                            otherUserCardUrlFB.observeSingleEventOfType(.Value, withBlock: { (cardSnapshot) -> Void in
                                                let theOtherUserCard = cardSnapshot.value
                                                
                                                //TODO: - Add the card into an array for all of the options
                                                if let ck = theCardKey.key{
                                                    if ck != ""{
                                                        self._cardId.append(ck as! String)
                                                    }else{
                                                        self._cardId.append("")
                                                    }
                                                }
                                                print(self._cardId)
                                                
                                                if let n = theOtherUserCard["Name"]{
                                                    if n != nil{
                                                        self._names.append(n as! String)
                                                    }else{
                                                        self._names.append("")
                                                    }
                                                }
                                                print(self._names)
                                                
                                                if let e = theOtherUserCard["Email"]{
                                                    if e != nil{
                                                        self._email.append(e as! String)
                                                    }else{
                                                        self._email.append("")
                                                    }
                                                }
                                                print(self._email)
                                                
                                                if let c = theOtherUserCard["Company"]{
                                                    if c != nil{
                                                        self._company.append(c as! String)
                                                    }else{
                                                        self._company.append("")
                                                    }
                                                }
                                                print(self._company)
                                                
                                                if let u = theOtherUserCard["userId"]{
                                                    if u != nil{
                                                        self._theOtherUserId.append(u as! String)
                                                    }else{
                                                        self._theOtherUserId.append("")
                                                    }
                                                }
                                                print(self._theOtherUserId)
                                                
                                            }, withCancelBlock: { (error ) -> Void in
                                                print(error)
                                            })
                                            
                                        }

                                    }, withCancelBlock: { (error ) -> Void in
                                        print(error)
                                    })
                                }
                            }, withCancelBlock: { (error ) -> Void in
                                print("There was an error")
                            })
                            
                            
                        }
                        
                        if let uId = snapshot2.value[Connections.UserId]{
                            self._id.append(uId as! String)
                        }

                    }, withCancelBlock: { (error ) -> Void in
                            
                    })
                    
                }
                
            }

        }) { (error) -> Void in
            print("There was an error trying to get the snapshot")
        }
        
    }
}