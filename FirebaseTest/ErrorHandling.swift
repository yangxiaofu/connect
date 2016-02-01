//
//  ErrorHandling.swift
//  BConnectTo
//
//  Created by Dave Dong on 1/31/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

enum createFireBaseEmailError:ErrorType{
    case InvalidType
    case InvalidEmail
    case EmailsAlreadyExists
    case UniqueIDNonExistent
}