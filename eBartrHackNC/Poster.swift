//
//  Poster.swift
//  eBartrHackNC
//
//  Created by Ziad Ali on 10/29/16.
//  Copyright © 2016 ZiadCorp. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import GeoFire

class Poster: NSObject, CLLocationManagerDelegate {
    
    func makePost(currentLocation:CLLocationCoordinate2D, post:[String:String]) {
        let ref = FIRDatabase.database().reference()
        let geoFireRef = GeoFire(firebaseRef: ref.child("Locations"))
        var postKey = ref.childByAutoId().key
        postKey = postKey.substring(from: postKey.index(postKey.startIndex, offsetBy: 1))
        postKey = postKey.replacingOccurrences(of: "_", with: "5")
        postKey = postKey.replacingOccurrences(of: "-", with: "7")
        let location = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        geoFireRef?.setLocation(location, forKey: postKey)
        ref.child(postKey).setValue(post)
    }
}
