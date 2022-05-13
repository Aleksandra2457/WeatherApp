//
//  WeatherListCollectionViewController.swift
//  WeatherApp
//
//  Created by Александра Лесовская on 01.05.2022.
//

import UIKit

@IBDesignable class WeatherListCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: - Public Properties
    var collectionView: UICollectionView!
    var addedLocations = [String]() {
        didSet {
            print(addedLocations)
        }
    }
    
    // MARK: - Private Properties
    private let weatherImages = [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "9",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19"]

    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: view.frame.width - 32, height: view.frame.height * 0.14)

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "WeatherCell")

        self.view.addSubview(collectionView)
        
        StorageManager.shared.createTemplateLocation()
        addedLocations = StorageManager.shared.fetchLocations()
        
    }

    // MARK: - Collection View Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addedLocations.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath as IndexPath) as! WeatherCollectionViewCell
        let location = addedLocations[indexPath.row]
        cell.setupItem()
        cell.showElements()
        cell.showLocation(location)
        cell.setupImageWith(name: self.weatherImages.randomElement() ?? "1")
        fetchWeather(for: location) { weather in
            DispatchQueue.main.async {
                cell.showTemperature(with: weather)
            }
        }
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = collectionView.indexPathsForSelectedItems else { return }
        print("Item was tapped")
    }
    
    // MARK: - Private Methods
    private func setupNavigationBar() {
        title = "Погода"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor.systemBackground

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationItem.leftBarButtonItem = UIBarButtonItem()
        navigationItem.leftBarButtonItem?.image = UIImage(systemName: "line.3.horizontal")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAlert))
        navigationController?.navigationBar.tintColor = .gray
    }
    
    private func fetchWeather(for city: String, completion: @escaping (CurrentWeather)  -> Void) {
        CoreLocationManager.shared.returnCoordinates(for: city) { latitude, longitude in
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

}

extension WeatherListCollectionViewController {
    
    // MARK: - Create Alert
    @objc func showAlert() {
        let alertController = UIAlertController.createAlert(withTitle: "Какой город Вы хотите найти?", andMessage: "Введите название для поиска и отображения")
        alertController.action { cityName in
            StorageManager.shared.addLocation(cityName)
            self.addedLocations.append(cityName)
            DispatchQueue.main.async {
                self.collectionView.insertItems(at: [IndexPath(item: self.addedLocations.endIndex - 1, section: 0)])
            }
        }
        present(alertController, animated: true)
    }
    
}

extension WeatherListCollectionViewController: WeatherCollectionViewCellDelegate {
    func delete(weatherItem: WeatherCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: weatherItem) {
            print(indexPath)
            let location = addedLocations.remove(at: indexPath.item)
            StorageManager.shared.deleteLocation(location)
            collectionView.deleteItems(at: [indexPath])
        }
    }
}

