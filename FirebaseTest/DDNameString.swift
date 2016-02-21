//
//  DDNameString.swift
//  BConnectTo
//
//  Created by Dave Dong on 2/14/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

class DDNameString{
    private var _fullName:String?
    private var _firstName:String?
    private var _lastName:String?
    private var _middleName:String?
    private var _suffix:String?
    
    var fullName:String{
        get{
            if let fn = self._fullName{
                return fn
            }else{
                return ""
            }
        }
        set{
            self._fullName = newValue
        }
    }
    
    var firstName:String{
        get{
            if let first = self._firstName{
                return first
            }else{
                return ""
            }
        }
        set{
            self._firstName = newValue
        }
    }
    
    var lastName:String{
        get{
            if let last = self._lastName{
                return last
            }else{
                return ""
            }
        }
        set{
            self._lastName = newValue
        }
    }
    
    var middleName:String{
        get{
            if let middle = self._middleName{
                return middle
            }else{
                return ""
            }
        }
        set{
            self._middleName = newValue
        }
    }
    
    var suffix:String{
        get{
            if let s = self._suffix{
                return s
            }else{
                return ""
            }
        }
        set{
            self._suffix = newValue
        }
    }
    
    init(fullName:String){
        self._fullName = fullName
        separateName(fullName)
    }
    
    init(firstName:String, middleName:String, lastName:String, suffix:String){
        self._firstName = firstName
        self._middleName = middleName
        self._lastName = lastName
        self._suffix = suffix
        self._fullName = "\(firstName) \(middleName) \(lastName) \(suffix)"
    }
    
    func separateName(fullName:String){
        print("My full name is \(fullName)")
        let fullNameArray = fullName.componentsSeparatedByString(" ")
        
        print("inside the separate name loop2")
        
        switch fullNameArray.count{
        case 0:
            print(0)
            return
        case 1:
            print(1)
            self._firstName = fullNameArray[0]
        case 2:
            print(2)
            self._firstName = fullNameArray[0]

            self._lastName = fullNameArray[1]
        case 3:
            print(3)
            self._firstName = fullNameArray[0]
            self._middleName = fullNameArray[1]
            self._lastName = fullNameArray[2]
        default:
            print(4)
            self._firstName = fullNameArray[0]

            self._lastName = fullNameArray[fullNameArray.count - 1]
        }
    }

}