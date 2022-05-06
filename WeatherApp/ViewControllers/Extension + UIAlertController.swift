//
//  Extension + UIAlertController.swift
//  WeatherApp
//
//  Created by Александра Лесовская on 05.05.2022.
//

import UIKit

extension UIAlertController {
    
    // MARK: - Static Methods
    static func createAlert(withTitle title: String, andMessage message: String) -> UIAlertController {
        UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    // MARK: - Public Methods
    func action(_ completion: @escaping (CurrentWeather) -> Void) {
        let searchAction = UIAlertAction(title: "Search", style: .default) { _ in
            guard let newCity = self.textFields?.first?.text else { return }
            guard !newCity.isEmpty else { return }
            CoreLocationManager.shared.returnCoordinates(for: newCity) { latitude, longitude in
                NetworkManager.shared.fetchWeather(latitude: latitude, longitude: longitude) { results in
                    switch results {
                    case .success(let weather):
                        completion(weather)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        addAction(searchAction)
        addAction(cancelAction)
        addTextField { textField in
            textField.placeholder = "City name"
        }
    }
    
    
}


