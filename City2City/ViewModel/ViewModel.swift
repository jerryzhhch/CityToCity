//
//  ViewModel.swift
//  City2City
//
//  Created by mac on 5/13/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func updateView()
}

class ViewModel {
    
    weak var delegate: ViewModelDelegate?
    
    private(set) var cities = [City]() {
        didSet {
            orderedCities = order(with: cities)
        }
    } //get only property
    
    private(set) var orderedCities = [String: [City]]() {
        didSet {
            delegate?.updateView()
        }
    }
    
    var filteredCities = [City]()
    
    var currentCity: City!
    
    func get() {
        
        cityService.getCities { [unowned self] cities in
            
            self.cities = cities
            print("City Count: \(self.cities.count)")
        }
    }
    
    
    //MARK: Order Functionality
    
    private func order(with cities: [City]) -> [ String : [City] ] {
        
        //container
        //        var dictionary = [String:[City]]()
        //
        //        for city in cities {
        //
        //            let first = city.name.prefix(1).uppercased()
        //
        //            if dictionary[first] == nil {
        //                dictionary[first] = [city]
        //            } else {
        //                dictionary[first]?.append(city)
        //            }
        //        }
        
        //create a dictionary
        var orderedCities = Dictionary(grouping: cities, by: {$0.name.prefix(1).uppercased()})
        
        //order these alphabetically
        for (key, value) in orderedCities {
            
            orderedCities[key] = value.sorted(by: {$0.name < $1.name})
            
        }
        
        
        return orderedCities
    }
    
    
} //end class
