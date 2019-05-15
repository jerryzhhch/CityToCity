//
//  WeatherService.swift
//  City2City
//
//  Created by mac on 5/15/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

typealias WeatherHandler = (Weather?, Error?) -> Void

let weatherService = WeatherService.shared


enum CustomError: Error {
    case badUrl(String)
}

final class WeatherService {
    
    
    static let shared = WeatherService()
    private init() {}
    
    
    
    func getWeather(from city: City, completion: @escaping WeatherHandler) {
        
        let urlString = WeatherAPI.getWeatherURL(from: city)
        
        guard let url = URL(string: urlString) else {
            completion(nil, CustomError.badUrl("Could not receive data from URL"))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            
            if let error = err {
                print("Bad Data: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            if let data = dat {
                
                do {
                    
                    let weather = try JSONDecoder().decode(Weather.self, from: data)
                    completion(weather, nil)
                    
                } catch let yellow {
                    print("Could Not Decode Object: \(yellow.localizedDescription)")
                    completion(nil, yellow)
                }
                
            }
        }.resume()
        
        
    } //end func
    
    

}
