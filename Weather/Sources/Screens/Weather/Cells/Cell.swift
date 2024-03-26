//
//  CollectionViewCell.swift
//  Weather
//
//  Created by Дрозд Денис on 29.02.2024.
//

import UIKit
import NukeExtensions

final class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        String(describing: self)
    }
    
    // MARK: - Views
    
    private var labelTime: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private var labelTemp: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private var imageForecast = UIImageView()
    
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
    
    func configure(with model: WeatherForecastHourly) {
        Task { NukeExtensions.loadImage(with: model.imageURL, into: imageForecast) }
        labelTime.text = model.date
        labelTemp.text = model.temperatureN
    }
    
    // MARK: - Layout
    
    private func addSubviews() {
        contentView.addSubview(labelTime)
        contentView.addSubview(imageForecast)
        contentView.addSubview(labelTemp)
    }
    
    private func makeConstraints() {
        labelTime.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(-EnumInt.twentyTwo)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        imageForecast.snp.makeConstraints { make in
            make.top.equalTo(labelTime.snp.bottom).offset(-EnumInt.five)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.width.equalTo(EnumInt.sixty)
        }
        
        labelTemp.snp.makeConstraints { make in
            make.top.equalTo(imageForecast.snp.bottom).offset(-EnumInt.five)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }
}
