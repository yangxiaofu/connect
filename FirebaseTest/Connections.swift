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
    private var _friendsArray = [Dictionary<String, String>()]
    private var _user_url = ""
    private var _user_ref:Firebase!
    
    
    var id:[String]{
        get{
            return self._id
        }
    }
    
    var userId:String{
        get{
            return self._userId
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
    var friendsArray:[Dictionary<String, String>]{
        get{
            return self._friendsArray
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
                                                if let n = theOtherUserCard["Name"]{
                                                    let name = n as! String
                                                    print(name)
                                                }else{
                                                    
                                                    //adds an empty string into the array
                                                }
                                                
                                                //TODO: - Add the profile URL Image
                                                
                                                //TODO: - Add the Company of the user in the array
                                                

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