//
//  WeatherListCollectionViewController.swift
//  WeatherApp
//
//  Created by Александра Лесовская on 01.05.2022.
//

import UIKit

class WeatherListCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var collectionView: UICollectionView!

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
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath as IndexPath) as! WeatherCollectionViewCell
        cell.setupItem()
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
        navigationItem.rightBarButtonItem = UIBarButtonItem()
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: "plus")

        navigationController?.navigationBar.tintColor = .gray
    }

}

