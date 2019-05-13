//
//  CityTableCell.swift
//  City2City
//
//  Created by mac on 5/13/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class CityTableCell: UITableViewCell {

    @IBOutlet weak var cityMainLabel: UILabel!
    @IBOutlet weak var citySubLabel: UILabel!
    
    static let identifier = "CityTableCell"
    
    func configure(with city: City) {
        
        cityMainLabel.text = "\(city.name), \(city.state)"
        citySubLabel.text = "Population: \(city.population)"
        
    }
}
