//
//  Annotation.swift
//  avenueproperties
//
//  Created by Alex Beattie on 9/26/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import MapKit
import Contacts

class ListingAnno: NSObject, MKAnnotation {
    var listing: Listing?
    
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title:String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
}


