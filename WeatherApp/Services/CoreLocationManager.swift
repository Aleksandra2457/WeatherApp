//
//  CoreLocationManager.swift
//  WeatherApp
//
//  Created by Александра Лесовская on 06.05.2022.
//

import Foundation
import CoreLocation

class CoreLocationManager {
    
    static let shared  = CoreLocationManager()
    
    private init() {}
    
    func returnCoordinates(for cityName: String, completion: @escaping (CLLocationDegrees, CLLocationDegrees) -> Void)  {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(cityName) { placemarks, error in
            if let city = placemarks?.last {
                let latitude = city.location?.coordinate.latitude ?? 0.0
                let longitude = city.location?.coordinate.longitude ?? 0.0
                completion(latitude, longitude)
            }
        }
    }
    
    
}
