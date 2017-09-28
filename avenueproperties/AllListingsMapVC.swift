//
//  AllListingsMapVC.swift
//  avenueproperties
//
//  Created by Alex Beattie on 9/28/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import MapKit
import Contacts


class AllListingsMapVC: UIViewController, MKMapViewDelegate {
    var mapView:MKMapView!
    var annotation:MKAnnotation!
    var pointAnnotation: MKPointAnnotation!
    var pinView:MKPinAnnotationView!

    var listings:[Listing]?

    func fetchListings() {
        ApiService.sharedInstance.fetchListings { (listings: [Listing]) in
            self.listings = listings
//            print(listings)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(listings)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchListings()

        let location = CLLocationCoordinate2D(latitude: 46.623988, longitude: -123.485756)
        let mapView = MKMapView()
        //mapView.delegate = self as! MKMapViewDelegate

        mapView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        view.addSubview(mapView)
        let initialLocation = CLLocation(latitude: 47.604147, longitude: -122.334518)
        let regionRadius: CLLocationDistance = 50000
        func centerMapOnLocation(location:CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 5.0, regionRadius * 5.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(location: initialLocation)
        
        let listing = AllListingsAnno(title: "alex", subTitle: "beattie", coordinate: location)
        mapView.addAnnotation(listing)
        
    }
//    func goOutToGetMap() {
//
//        if let lat = listings.geo.lat {
//            lat = lat
//        }
//        if let lng = listing?.geo?.lng {
//            lng = lng
//        }
//
//
//        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
//
//        let placemark = MKPlacemark(coordinate: location, addressDictionary: nil)
//
//        let item = MKMapItem(placemark: placemark)
//
//        item.name = listing?.address?.full?.capitalized
//
//        item.openInMaps (launchOptions: [MKLaunchOptionsMapTypeKey: 2,
//                                         MKLaunchOptionsMapCenterKey:NSValue(mkCoordinate: placemark.coordinate),
//                                         MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving])
//    }
    
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//
//
//        let alertController = UIAlertController(title: nil, message: "Driving directions", preferredStyle: .actionSheet)
//        let OKAction = UIAlertAction(title: "Get Directions", style: .default) { (action) in
//            self.goOutToGetMap()
//        }
//        alertController.addAction(OKAction)
//
//        present(alertController, animated: true) { }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
//        alertController.addAction(cancelAction)
//    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
        annoView.pinTintColor = #colorLiteral(red: 0.5137254902, green: 0.8470588235, blue: 0.8117647059, alpha: 1)
        annoView.animatesDrop = true
        annoView.canShowCallout = true
        let swiftColor = #colorLiteral(red: 0.5137254902, green: 0.8470588235, blue: 0.8117647059, alpha: 1)
        annoView.centerOffset = CGPoint(x: 100, y: 400)
        annoView.pinTintColor = swiftColor
        
        // Add a RIGHT CALLOUT Accessory
        let rightButton = UIButton(type: UIButtonType.detailDisclosure)
        rightButton.frame = CGRect(x:0, y:0, width:32, height:32)
        rightButton.layer.cornerRadius = rightButton.bounds.size.width/2
        rightButton.clipsToBounds = true
        rightButton.tintColor = #colorLiteral(red: 0.5137254902, green: 0.8470588235, blue: 0.8117647059, alpha: 1)
        
        annoView.rightCalloutAccessoryView = rightButton
        
        //Add a LEFT IMAGE VIEW
        let leftIconView = UIImageView()
        leftIconView.contentMode = .scaleAspectFill
        
        
        let newBounds = CGRect(x:0.0, y:0.0, width:54.0, height:54.0)
        leftIconView.bounds = newBounds
        annoView.leftCalloutAccessoryView = leftIconView
        
        return annoView
    }
}
