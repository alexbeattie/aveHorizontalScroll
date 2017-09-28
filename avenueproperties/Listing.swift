//
//  Listing.swift
//  avenueproperties
//
//  Created by Alex Beattie on 9/25/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit


struct Listing: Decodable {
    var listPrice: Int?
    var photos: [String]?
    var address: Address?
    var mlsId: Int?
    var listingId: String?
    var property: Property?
    var geo: Geo?
    var remarks: String?
    var virtualTourUrl: String?
    
    struct Address: Decodable {
        var full: String?
    }
    
    struct Property: Decodable {
        var bathsFull: Int?
        var bathsHalf: Int?
        var bedrooms: Int?
    }
    struct Geo: Decodable {
        var lat: Double?
        var lng: Double?
    }
    static func fetchListing(_ completionHandler: @escaping ([Listing]) -> ()) {
//        let baseUrl = URL(string: "http://localhost:8888/simplyrets/file.js")
        let baseUrl = URL(string: "http://artisanbranding.s3.amazonaws.com/file.js")

        let task = URLSession.shared.dataTask(with: baseUrl!) { (data, response, error) in
            
            guard let data = data else { return }
            if let error = error {
                print(error)
            }
            
            do {
                
                let decoder = JSONDecoder()
                let listing = try decoder.decode([Listing].self, from: data)
                
                //print(listing)
                DispatchQueue.main.async(execute: { () -> Void in
                    completionHandler(listing)
                })
            } catch let err {
                print(err)
            }
            
        }
        task.resume()
    }
}
