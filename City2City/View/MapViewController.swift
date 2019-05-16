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
    
    func getWeather() {
        
       weatherService.getWeather(from: viewModel.currentCity) { [unowned self] (wthr, err) in
            
            if let error = err {
                
                self.showAlert(
                    title: "Could Not Access Weather: \(self.viewModel.currentCity.name), \(self.viewModel.currentCity.state)",
                    message: error.localizedDescription)
            }
        
            
            if let weather = wthr {
                self.viewModel.currentWeather = weather
                print("\(self.viewModel.currentCity.name), \(self.viewModel.currentCity.state), Weather: \(weather.weather.first!.description)")
            }
        }
    }
    
    
    //MARK: Setup Map

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
    
    
    //MARK: Bar Button Items
    
    @objc func getWeatherInstance() {
        let alert = AlertViewController.weatherInstance(with: viewModel)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func createBarButtonItems() {
        
        let weatherButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(getWeatherInstance))
        navigationItem.rightBarButtonItem = weatherButton
        
    }
    

}


