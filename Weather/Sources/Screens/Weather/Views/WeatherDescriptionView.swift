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
        let label = WeatherDescriptionLabel(size: EnumInt.fourty)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let temperatureLabel = WeatherDescriptionLabel(size: EnumInt.fourty)
    private let weatherImageView = UIImageView()
    private let currentWeatherLabel = WeatherDescriptionLabel(size: EnumInt.twentyFive)
    private let feelsAsLabel = WeatherDescriptionLabel(size: EnumInt.twenty)
    private let windSpeedLabel = WeatherDescriptionLabel(size: EnumInt.seventeen)
    private let humidityLabel = WeatherDescriptionLabel(size: EnumInt.seventeen)
    private let pressureLabel = WeatherDescriptionLabel(size: EnumInt.seventeen)
    
    private let parametersStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = EnumInt.fifteen
        return stack
    }()
    
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
        temperatureLabel.text = model.temperatureN
        currentWeatherLabel.text = model.currentWeatherN
        feelsAsLabel.text = model.feelsAsN
        windSpeedLabel.text = model.windSpeedN
        humidityLabel.text = model.humidityN
        pressureLabel.text = model.pressureN
    }
}

// MARK: - Layout

private extension WeatherDescriptionView {
    
    func addSubviews() {
        addSubview(regionLabel)
        addSubview(temperatureLabel)
        addSubview(weatherImageView)
        addSubview(currentWeatherLabel)
        addSubview(feelsAsLabel)
        addSubview(parametersStack)
        parametersStack.addArrangedSubview(windSpeedLabel)
        parametersStack.addArrangedSubview(humidityLabel)
        parametersStack.addArrangedSubview(pressureLabel)
        addSubview(collectionView)
    }
    
    func makeConstraints() {
        regionLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(EnumInt.twenty)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(regionLabel.snp.bottom).offset(EnumInt.fifteen)
            make.centerX.equalToSuperview().offset(-EnumInt.fourty)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(regionLabel.snp.bottom)
            make.centerX.equalToSuperview().offset(EnumInt.fifty)
            make.size.lessThanOrEqualTo(EnumInt.ninety)
        }
        
        currentWeatherLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.lessThanOrEqualTo(EnumInt.fifty)
        }
        
        feelsAsLabel.snp.makeConstraints { make in
            make.top.equalTo(currentWeatherLabel.snp.bottom)
            make.bottom.equalTo(parametersStack.snp.top)
            make.centerX.equalToSuperview()
            make.height.lessThanOrEqualTo(EnumInt.fifty)
        }
        
        parametersStack.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-EnumInt.eighteen)
            make.leading.equalToSuperview().offset(EnumInt.fifteen)
            make.height.equalTo(collectionView)
        }
        
        collectionView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-EnumInt.twenty)
            make.trailing.equalToSuperview().offset(-EnumInt.twelve)
            make.height.equalTo(EnumInt.ninety)
            make.leading.equalTo(parametersStack.snp.trailing).offset(EnumInt.nine)
        }
    }
}
