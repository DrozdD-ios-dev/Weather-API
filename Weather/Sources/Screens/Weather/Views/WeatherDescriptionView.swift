//
//  WeatherDescriptionView.swift
//  Weather
//
//  Created by Дрозд Денис on 01.03.2024.
//

import UIKit
import NukeExtensions

final class WeatherDescriptionView: UIView {
    
    // MARK: - Views
    
    private let regionLabel: UILabel = {
        let label = WeatherDescriptionLabel(size: 38)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    private let temperatureLabel = WeatherDescriptionLabel(size: 40)
    private let weatherImageView = UIImageView()
    private let currentWeatherLabel = WeatherDescriptionLabel(size: 24)
    private let feelsAsLabel = WeatherDescriptionLabel(size: 20)
    private let windSpeedLabel = WeatherDescriptionLabel(size: 17)
    private let humidityLabel = WeatherDescriptionLabel(size: 17)
    private let pressureLabel = WeatherDescriptionLabel(size: 17)
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Functions
    
    func configure(with model: WeatherDescription) {
        Task { NukeExtensions.loadImage(with: model.imageURL, into: weatherImageView) }
        regionLabel.text = model.region
        temperatureLabel.text = model.temperature
        currentWeatherLabel.text = model.currentWeather
        feelsAsLabel.text = model.feelsAs
        windSpeedLabel.text = model.windSpeed
        humidityLabel.text = model.humidity
        pressureLabel.text = model.pressure
    }
}

// MARK: - Layout

extension WeatherDescriptionView {
    
    private func addSubviews() {
        addSubview(regionLabel)
        addSubview(temperatureLabel)
        addSubview(weatherImageView)
        addSubview(currentWeatherLabel)
        addSubview(feelsAsLabel)
        addSubview(windSpeedLabel)
        addSubview(humidityLabel)
        addSubview(pressureLabel)
        addSubview(collectionView)
    }
    
    private func makeConstraints() {
        regionLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.top.equalToSuperview().inset(20)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(regionLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview().offset(-41) //
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(regionLabel.snp.bottom).offset(-6)
            make.centerX.equalToSuperview().offset(50) //
            make.size.equalTo(90) // height, width
        }
        
        currentWeatherLabel.snp.makeConstraints { make in
            make.bottom.equalTo(feelsAsLabel.snp.top).offset(-15)
            make.centerX.equalToSuperview()
        }
        
        feelsAsLabel.snp.makeConstraints { make in
            make.bottom.equalTo(windSpeedLabel.snp.top).offset(-15)
            make.centerX.equalToSuperview()
        }
        
        windSpeedLabel.snp.makeConstraints { make in
            make.bottom.equalTo(humidityLabel.snp.top).offset(-15)
            make.leading.equalToSuperview().offset(15)
        }
        
        humidityLabel.snp.makeConstraints { make in
            make.bottom.equalTo(pressureLabel.snp.top).offset(-15)
            make.leading.equalToSuperview().offset(15)
        }
        
        pressureLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-18)
            make.leading.equalToSuperview().offset(15)
        }
        
        collectionView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-21)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(90)
            make.leading.equalTo(humidityLabel.snp.trailing).offset(5)
        }
    }
}
