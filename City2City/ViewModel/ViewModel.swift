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
            delegate?.updateView()
        }
    } //get only property
    
    
    func get() {
        
        cityService.getCities { [unowned self] cities in
            
            self.cities = cities
            print("City Count: \(self.cities.count)")
        }
    }
    
    
} //end class
