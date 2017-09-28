//
//  ApiService.swift
//  avenueproperties
//
//  Created by Alex Beattie on 9/28/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    func fetchListings(completion: @escaping ([Listing]) -> ()) {
        
        //        let url = URL(string: "http://localhost:8888/simplyrets/file.js")!
        let url = URL(string: "http://artisanbranding.s3.amazonaws.com/file.js")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var listings = [Listing]()
                
                for dictionary in json as! [[String:Any]] {
                    
                    var listing = Listing()
//                    // listing.listDate = dictionary["listDate"] as? String
//                    if let theListDate = dictionary["listDate"] as? String {
//                        listing.listDate = theListDate
//                        print("The date listed is: \(theListDate)")
//                    }
//                    // listing.listPrice = dictionary["listPrice"] as? NSNumber
//                    if let theListPrice = dictionary["listPrice"] as? NSNumber {
//                        listing.listPrice = theListPrice
//                        print("The listed price is: \(theListPrice)")
//                    }
//                    if let theAddress = dictionary["address"] as? [String:Any]  {
//                        if let fullAddress = theAddress["full"] as? String {
//                            listing.address = fullAddress
//                            print("The full address is: \(fullAddress)")
//                        }
//                    }
//                    if let theMlsId = dictionary["mlsId"] as? Int {
//                        listing.mlsId = theMlsId
//                        print("The mlsId is: \(theMlsId)")
//                    }
                    if let geo = dictionary["geo"] as? [String:Any]  {
                        if let theLng = geo["lng"] as? Double {
                            if let theLat = geo["lat"] as? Double {
                                listing.geo?.lat = theLat
                                listing.geo?.lng = theLng
                                print("The coords are: \(theLat),\(theLng)\n")
                            }
                        }
                    }
                    // the array of photos are
//                    if let thePhotos = dictionary["photos"] as? [Any] {
//                        if let allPhotos = listing.photos {
//                            listing.photos = allPhotos
//                        }
//                        if let theFirst = thePhotos.first {
//                            listing.mainImage = theFirst as? String
//                            print("The first photo is: \(theFirst)")
//                        }
//                        print("The photos are: \(thePhotos)")
//                    }
                    listings.append(listing)
                }
                DispatchQueue.main.async {
                    completion(listings)
                }
            } catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
    }
}


