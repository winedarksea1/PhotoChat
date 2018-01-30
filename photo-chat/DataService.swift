//
//  DataService.swift
//  photo-chat
//
//  Created by Andrew McGovern on 1/27/18.
//  Copyright © 2018 Andrew McGovern. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

let FIR_CHILD_USERS = "users"

class DataService {
    private static let _instance = DataService()
    
    static var instance: DataService {
        return _instance
    }
    
    var mainRef: DatabaseReference {
        return Database.database().reference()
    }
    
    var usersRef: DatabaseReference {
        return mainRef.child(FIR_CHILD_USERS)
    }
    
    var mainStorageRef: StorageReference {
        return Storage.storage().reference()
    }
    
    var imagesStorageRef: StorageReference {
        return mainStorageRef.child("images")
    }
    
    var videoStorageReference: StorageReference {
        return mainStorageRef.child("videos")
    }
    
    func saveUser(uid: String) {
        let profile: Dictionary<String, Any> = ["firstName": "", "lastName": ""]
        mainRef.child(FIR_CHILD_USERS).child(uid).child("profile").setValue(profile)
    }
}
