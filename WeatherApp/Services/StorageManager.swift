//
//  StorageManager.swift
//  WeatherApp
//
//  Created by Александра Лесовская on 05.05.2022.
//

import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let locationsKey = "AddedLocations"
    
    private init() {}
    
    func createTemplateLocation() {
        if !userDefaults.bool(forKey: "TemplateDataWasCreated") {
            let locations = ["Moscow"]
            userDefaults.setValue(locations, forKey: locationsKey)
        }
        userDefaults.set(true, forKey: "TemplateDataWasCreated")
    }
    
    func addLocation(_ cityName: String) {
        var locations = fetchLocations()
        locations.append(cityName)
        userDefaults.setValue(locations, forKey: locationsKey)
    }
    
    func deleteLocation(_ cityname: String) {
        var locations = fetchLocations()
        if let index = locations.firstIndex(of: cityname) {
            locations.remove(at: index)
            userDefaults.setValue(locations, forKey: locationsKey)
        }
    }
    
    func fetchLocations() -> [String] {
        return userDefaults.value(forKey: locationsKey) as? [String] ?? []
    }
    
}
