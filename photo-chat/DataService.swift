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

import CoreLocation

let FIR_CHILD_USERS = "users"

class DataService {
    private static let _instance = DataService()
    
    // Added this
    private let userLocation = CLLocationCoordinate2D()
    
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
        let profile: Dictionary<String, Any> = ["firstName": "", "lastName": "", "imgURL": ""]
        mainRef.child(FIR_CHILD_USERS).child(uid).child("profile").setValue(profile)
    }
    
    // get info for a specific user
    func getUserInfo(uid: String) -> DatabaseReference {
        return mainRef.child(FIR_CHILD_USERS).child(uid).child("profile")
    }
    
    func sendMediaPullRequest(senderUID: String, sendingTo: Dictionary<String, User>, mediaURL: URL, usersLatitude: Double, usersLongitude: Double, textSnippet: String? = nil) {
        var uids = [String]()
        for uid in sendingTo.keys {
            uids.append(uid)
        }
        
        let pr: Dictionary<String, Any> = [
            "mediaURL": mediaURL.absoluteString,
            "userID": senderUID,
            "openCount": 0,
            "reciptients": uids,
            "usersLatitude": usersLatitude,
            "usersLongitude": usersLongitude
        ]
        
        let reference = mainRef.child("pullRequests").childByAutoId()
        reference.setValue(pr)
        let childAutoId = reference.key
        
        let location = CLLocation(latitude: usersLatitude, longitude: usersLongitude)
//        geoFire?.setLocation(location, forKey: childAutoId)
        
        geoFire?.setLocation(CLLocation(latitude: usersLatitude, longitude: usersLongitude), forKey: childAutoId) { (error) in
            if (error != nil) {
                print("An error occured: \(error)")
            } else {
                print("Saved location successfully!")
            }
        }

    }
}
