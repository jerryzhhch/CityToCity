//
//  City.swift
//  City2City
//
//  Created by mac on 5/13/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import CoreLocation

enum SerializationError: Error {
    case missingProperty(String)
}


class City {
    
    let name: String
    let coordinates: CLLocationCoordinate2D
    let state: String
    let rank: String
    let population: String
    
    init?(json: [String:Any]) throws {
        
        guard let city = json["city"] as? String,
            let longitude = json["longitude"] as? Double,
            let latitude = json["latitude"] as? Double,
            let state = json["state"] as? String,
            let rank = json["rank"] as? String,
            let population = json["population"] as? String else {
            throw SerializationError.missingProperty("Could not serialize JSON")
        }
        
        self.name = city
        self.coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.state = state
        self.rank = rank
        self.population = population
        

    }
    
    
    
}
