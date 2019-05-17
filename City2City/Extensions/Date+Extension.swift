//
//  Date+Extension.swift
//  City2City
//
//  Created by mac on 5/17/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation



extension Date {
    
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
    
    
    
}
