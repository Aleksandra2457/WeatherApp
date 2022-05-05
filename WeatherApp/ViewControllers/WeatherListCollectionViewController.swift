//
//  WeatherListCollectionViewController.swift
//  WeatherApp
//
//  Created by Александра Лесовская on 01.05.2022.
//

import UIKit

class WeatherListCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var collectionView: UICollectionView!
    
    var addedLocations: CurrentWeather! {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private let weatherImages = ["1", "2", "3", "4", "5", "6", "7", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: view.frame.width - 32, height: view.frame.height * 0.14)

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "WeatherCell")

        self.view.addSubview(collectionView)
        
        DispatchQueue.main.async {
            NetworkManager.shared.fetchWeather { result in
                switch result {
                case .success(let current):
                    self.addedLocations = current
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath as IndexPath) as! WeatherCollectionViewCell
        cell.setupItem()
        if addedLocations != nil {
            cell.setupUI(with: addedLocations)
            cell.showElements()
            cell.setupImageWith(name: weatherImages.randomElement() ?? "1")
        }
        return cell
    }
    
    private func setupNavigationBar() {
        title = "Weather"
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

}

extension WeatherListCollectionViewController {
    
}

