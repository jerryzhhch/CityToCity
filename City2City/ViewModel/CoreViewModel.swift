//
//  CoreViewModel.swift
//  City2City
//
//  Created by mac on 5/16/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation


class CoreViewModel {
    
    var coreCities = [CoreCity]() {
        didSet {
            NotificationCenter.default.post(name: Notification.Name.CoreNotification, object: nil)
        }
    }
    
    
    
    func get() {
       coreCities = coreManager.getCoreCities()
    }
    
    
}
