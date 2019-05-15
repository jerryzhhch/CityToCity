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
        getWeather()
        createBarButtonItems()
        
    }
    
    
    
    //MARK: Weather
    
    @objc func getWeather() {
        
       weatherService.getWeather(from: viewModel.currentCity) { [unowned self] (wthr, err) in
            
            if let error = err {
                
                self.showAlert(
                    title: "Could Not Access Weather: \(self.viewModel.currentCity.name), \(self.viewModel.currentCity.state)",
                    message: error.localizedDescription)
            }
        
            
            if let weather = wthr {
                
                self.viewModel.currentWeather = weather
                print("Weather: \(weather.weather.first!.description)")
            }
        }
    }
    
    
    //MARK: Setup

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
    
    
    func createBarButtonItems() {
        
        let weatherButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(getWeather))
        navigationItem.rightBarButtonItem = weatherButton
        
    }
    

}


