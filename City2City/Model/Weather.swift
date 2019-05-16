//
//  Weather.swift
//  City2City
//
//  Created by mac on 5/15/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation


class Weather: Decodable {
    
    
    let weather: [WeatherInfo]
    let main: Main
    let wind: Wind
    
}

struct WeatherInfo: Decodable {
    
    let description: String
    let icon: String
    
}

struct Main: Decodable {
    
    let temperature: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case humidity
    }
    
}


struct Wind: Decodable {
    
    let speed: Double
    
}
