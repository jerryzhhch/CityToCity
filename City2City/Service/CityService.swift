//
//  CityService.swift
//  City2City
//
//  Created by mac on 5/13/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

typealias CityHandler = ([City]) -> Void

let cityService = CityService.shared

final class CityService {
    
    
    static let shared = CityService()
    private init() {}
    
    
    func getCities(completion: @escaping CityHandler) {
        
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            
            //container
            var cities = [City]()
            
            if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
                
                
                //construct URL
                let url = URL(fileURLWithPath: path)
                
                do {
                    //retrieve contents from url
                    let data = try Data(contentsOf: url)
                    
                    //JSON Serialization
                    let cityJSON = try JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
                    
                    
                    for json in cityJSON {
                        
                        if let city = try City(json: json) {
                            cities.append(city)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completion(cities)
                    }
                    
                } catch {
                    
                    print("Could Not Serialize: \(error.localizedDescription)")
                    completion([])
                }
                
            } //end func
            
            
            
            
            
            
            
            
            
            
            
            
        }
        
        
        
    }
    
    
    
    
    
    
    
    
}
