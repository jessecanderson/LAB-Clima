//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "daa8a9e8325a75abf5b6b16a74e55b42"
    /***Get your own App ID at https://openweathermap.org/appid ****/
    

    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()

    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
        
        
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    // Updated in the NetworkingModel.swift file.

    

    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
    // I updated a new class inside the NetworkModel.swift file with the JSON parsing using Codable.
    // This seemed to be cleaner and a bit more flexable.
    

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    func updateUIWithWeatherData(_ weatherData: Response) {
        temperatureLabel.text = String(format: "%0.0f°", (weatherData.main.temp * 9/5 - 459.67))
        cityLabel.text = weatherData.name
        weatherIcon.image = UIImage(named: Main.updateWeatherIcon(condition: (weatherData.weather.first?.id)!))
    }
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else {
           return
        }
        
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
        }
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        
        let params: [String: String] = ["lat": latitude, "lon": longitude, "appid": APP_ID]
        
        Networking.getWeatherData(from: WEATHER_URL, parameters: params) { (response: Response?) in
            guard let weatherResponse = response else {
                self.cityLabel.text = "There was an error"
                return
            }
            
            DispatchQueue.main.async {
                self.updateUIWithWeatherData(weatherResponse)
            }
        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        
        cityLabel.text = "City Unknown"
    }
    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    

    
    //Write the PrepareForSegue Method here
    
    
    
    
    
}


