//
//  ViewController+Extension.swift
//  City2City
//
//  Created by mac on 5/15/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(okay)
        present(alert, animated: true, completion: nil)
    }
    
    
}
