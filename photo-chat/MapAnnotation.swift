//
//  MapAnnotation.swift
//  photo-chat
//
//  Created by Andrew McGovern on 2/1/18.
//  Copyright © 2018 Andrew McGovern. All rights reserved.
//

import Foundation
import MapKit

class MapAnnotation: NSObject, MKAnnotation {
    var _coordinate: CLLocationCoordinate2D
    
    var key: String!
    var title: String?
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return _coordinate
        }
        set {
            _coordinate = newValue
        }
    }

    
    init(coordinate: CLLocationCoordinate2D, key: String) {
        self._coordinate = coordinate
        self.key = key
        self.title = key
    }
}
