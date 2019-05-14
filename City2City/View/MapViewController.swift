//
//  MapViewController.swift
//  City2City
//
//  Created by mac on 5/14/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!

    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        
        //TODO: Get Weather
        //TODO: Add Bar Button Item
    }
    

    private func setupMap() {
        
        let coordinates = viewModel.currentCity.coordinates
        
        let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        let location = MKPointAnnotation()
        location.coordinate = coordinates
        location.title = "\(viewModel.currentCity.name)"
        location.subtitle = "\(viewModel.currentCity.state)"
        
        mapView.addAnnotation(location)
        mapView.setRegion(region, animated: true)
        
    }
    

}


