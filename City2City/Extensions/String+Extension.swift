//
//  String+Extension.swift
//  City2City
//
//  Created by mac on 5/14/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation


extension String {
    
    
    func withCommas() -> String? {
        
        guard let number = Int(self) else {
            return nil
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }
    
    
    var addCommas: String? {
        
        guard let number = Int(self) else {
            return nil
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }
    
    
    
}
