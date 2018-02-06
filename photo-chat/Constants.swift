//
//  Constants.swift
//  photo-chat
//
//  Created by Andrew McGovern on 2/4/18.
//  Copyright © 2018 Andrew McGovern. All rights reserved.
//

import Foundation
import FirebaseDatabase

let databaseReference = Database.database().reference()
let geoFire = GeoFire(firebaseRef: databaseReference)

