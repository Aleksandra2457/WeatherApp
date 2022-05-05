//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Александра Лесовская on 04.05.2022.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private var deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.setImage(UIImage(systemName: "x.circle"), for: .normal)
        deleteButton.tintColor = .white
        return deleteButton
    }()
    
    private var degreesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 70)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    private var degreesSymbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .white
        label.text = "O"
        return label
    }()
    
    private var locationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    // MARK: - Public Methods
    func setupItem() {
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.addSubview(deleteButton)
        imageView.addSubview(degreesLabel)
        degreesLabel.addSubview(degreesSymbolLabel)
        imageView.addSubview(locationLabel)
        
        setupConstraints()
    }
    
    func setupImageWith(name: String) {
        imageView.image = UIImage(named: name)
    }
    
    func setupUI(with weather: CurrentWeather) {
        locationLabel.text = weather.zone
        degreesLabel.text = String(weather.current.temperature)
    }
    
    func showElements() {
        deleteButton.isHidden = false
        degreesSymbolLabel.isHidden = false
    }
    
    // MARK: - Private Methods

    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            deleteButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            deleteButton.widthAnchor.constraint(equalToConstant: 20.0),
            deleteButton.heightAnchor.constraint(equalToConstant: 20.0)
        ])
        
        deleteButton.isHidden = true
        
        degreesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            degreesLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -8),
            degreesLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -21),
            degreesLabel.heightAnchor.constraint(equalToConstant: frame.height * 0.3),
            degreesLabel.widthAnchor.constraint(equalToConstant: frame.width * 0.15)
        ])
        
        degreesSymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            degreesSymbolLabel.topAnchor.constraint(equalTo: degreesLabel.topAnchor, constant: 0),
            degreesSymbolLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            degreesSymbolLabel.heightAnchor.constraint(equalTo: degreesLabel.heightAnchor, multiplier: 0.4),
            degreesSymbolLabel.widthAnchor.constraint(equalToConstant: 15)
        ])
        
        degreesSymbolLabel.isHidden = true
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -8),
            locationLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
            locationLabel.trailingAnchor.constraint(equalTo: degreesLabel.leadingAnchor, constant: -5),
            locationLabel.heightAnchor.constraint(equalToConstant: frame.height * 0.3)
        ])
    }
    
}
