//
//  Weather.swift
//  WeatherApp
//
//  Created by Александра Лесовская on 04.05.2022.
//

import Foundation

struct CurrentWeather: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let current: Current
    
    var zone: String {
        let zone = timezone.split(separator: "/")
        return String(zone[1])
    }
}

struct Current: Codable {
    let dt: Double
    let temp: Double
    let feels_like: Double
    let weather: [Weather]
    
    var temperature: String {
        String(format: "%.0f", temp)
    }
    
}

struct Weather: Codable {
    let description: String
}
