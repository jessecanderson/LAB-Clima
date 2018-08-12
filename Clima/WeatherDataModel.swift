//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Angela Yu on 24/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

struct Response: Codable {
    let coord: Coord
    let sys: Sys
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let rain: Rain?
    let clouds: Clouds
    let dt: Int
    let id: Int
    let name: String
    let cod: Int
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
    let pressure: Int
    let temp_min: Double
    let temp_max: Double
    
    static func updateWeatherIcon(condition: Int) -> String {
        
        switch condition {
        case 0...300:
            return "tstorm1"
        case 301...500:
            return "light_rain"
        case 501...600:
            return "shower3"
        case 601...700:
            return "snow4"
        case 701...771:
            return "fog"
        case 772...799:
            return "tstorm3"
        case 800:
            return "sunny"
        case 801...804:
            return "cloudy2"
        case 900...903, 905...1000  :
            return "tstorm3"
        case 903 :
            return "snow5"
        case 904 :
            return "sunny"
        default :
            return "dunno"
        }
    }
}

struct Coord: Codable {
    let lon: Float
    let lat: Float
}

struct Clouds: Codable {
    let all: Int
}

struct Rain: Codable {
    let threeHours: Int
}

struct Sys: Codable {
    let country: String
    let sunrise: Int
    let sunset: Int
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Double?
    let deg: Double?
}
