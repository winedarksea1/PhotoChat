//
//  User.swift
//  photo-chat
//
//  Created by Andrew McGovern on 1/28/18.
//  Copyright © 2018 Andrew McGovern. All rights reserved.
//

import UIKit

struct User {
    var _firstName: String!
    var _uid: String!
    
    var uid: String {
        return _uid
    }
    
    var firstName: String {
        return _firstName
    }
    
    init(uid: String, firstName: String) {
        _uid = uid
        _firstName = firstName
    }
}
