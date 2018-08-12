//
//  NetworkingModel.swift
//  Clima
//
//  Created by Jesse Anderson on 8/12/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class Networking {
    
    // TODO: I need to do more error handling. I make a LOT of assumptions in here and don't handle them all gracefully. 
    static func getWeatherData(from url: String, parameters: [String: String], completion: @escaping (_ weatherResponse: Response?) -> Void)  {
        
        guard let lat = parameters["lat"], let lon = parameters["lon"], let appID = parameters["appid"] else {
            return
        }
        
        let apiRequestURL = URL(string: url + "?lat=" + lat + "&lon=" + lon + "&appid=" + appID)
        
        // print(apiRequestURL)
        URLSession.shared.dataTask(with: apiRequestURL!) { (data, response, error) in
            
            if error != nil {
                print("\(String(describing: error!.localizedDescription))")
            }
            
            guard let data = data else {
                return
            }
            
            completion(CustomJSONFuntions.parseJSONFrom(data: data))
            
            }.resume()
        
    }
        
}

class CustomJSONFuntions {
    
    static func parseJSONFrom(data: Data) -> Response {
        var weatherResponse: Response?
        
        do {
            
            weatherResponse = try JSONDecoder().decode(Response.self, from: data)
            
        } catch let jsonError {
            print(jsonError)
        }
        
        // Ok, it's a force unwrap to return the value, not what I want.
        // TODO: Update this so I don't have to force unwrap.
        return weatherResponse!
    }
}
