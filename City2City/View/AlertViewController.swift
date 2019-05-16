//
//  AlertViewController.swift
//  City2City
//
//  Created by mac on 5/15/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupWeather()
    }
    

    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        
        if touch.view == self.view {
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func setupWeather() {
        
        guard let city = viewModel.currentCity, let weather = viewModel.currentWeather else {
            return
        }
        
        mainView.layer.cornerRadius = 25
        mainView.clipsToBounds = false
        
        cityLabel.text = "\(city.name), \(city.state)"
        weatherDescriptionLabel.text = weather.weather.first!.description
        tempLabel.text = "Temperature: \(weather.main.temperature)"
        humidityLabel.text = "Humidity: \(weather.main.humidity)"
        windSpeedLabel.text = "Wind Speed: \(weather.wind.speed)"
        
    }

}

extension AlertViewController {
    
    static func weatherInstance(with viewModel: ViewModel) -> AlertViewController {
        
        let storyboard = UIStoryboard(name: "Alert", bundle: Bundle.main)
        
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        
        alertVC.viewModel = viewModel
        
        return alertVC
        
    }
}
