//
//  AllListingsAnno.swift
//  avenueproperties
//
//  Created by Alex Beattie on 9/28/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import MapKit

class AllListingsAnno: NSObject, MKAnnotation {
    let title: String?
    let subTitle: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subTitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subTitle = subTitle
        self.coordinate = coordinate
        
        super.init()
    }
//    init?(listing: [Listing.self]) {
//        // 1
//        self.title = listing.address.full.capitialized as? String ?? "No Title"
//        self.subTitle = address.full.capitialized as! String
//        
//        // 2
//        if let latitude = Double(listing.geo.lng as! String),
//            let longitude = Double(listing.geo.lat as! String) {
//            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        } else {
//            self.coordinate = CLLocationCoordinate2D()
//        }
//    }
}


