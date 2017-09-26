//
//  Annotation.swift
//  avenueproperties
//
//  Created by Alex Beattie on 9/26/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import MapKit
import Contacts

class Annotation: NSObject, MKAnnotation {
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
    
    //    init?(json: [Any]) {
    //        self.title = listing?.address
    ////        self.subtitle = listing?.listPrice
    //
    //        // 2
    //        if let latitude = Double(listing?.geoLng as! String),
    //            let longitude = Double(listing?.geoLat as! String) {
    //            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    //        } else {
    //            self.coordinate = CLLocationCoordinate2D()
    //        }
    //    }
    // annotation callout opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        //        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    
}

