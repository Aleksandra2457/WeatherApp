//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Александра Лесовская on 04.05.2022.
//

import Foundation

private let APIkey = "f2cf090b31b90222dbff2831eb624a93"

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchWeather(latitude: Double = 55.45, longitude: Double = 37.36, completion: @escaping (Result<CurrentWeather,Error>) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&units=metric&exclude=daily&appid=\(APIkey)") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error")
                return
            }
            do {
                let current = try JSONDecoder().decode(CurrentWeather.self, from: data)
                print(current)
                completion(.success(current))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
}
