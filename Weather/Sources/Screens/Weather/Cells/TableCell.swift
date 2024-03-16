//
//  TableCell.swift
//  Weather
//
//  Created by Дрозд Денис on 29.02.2024.

import UIKit
import NukeExtensions

final class TableViewCell: UITableViewCell {
    
    // MARK: - Views
    
    var tempDay: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "AppleSDGothicNeo-light", size: 25)
        return label
    }()
    
    var tempNight: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont(name: "AppleSDGothicNeo-light", size: 25)
        return label
    }()
    
    var labelData: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "AppleSDGothicNeo-light", size: 25)
        return label
    }()
    
    var imageWeather: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .clear
        
        contentView.addSubview(labelData)
        labelData.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(20)
        }
        
        contentView.addSubview(tempNight)
        tempNight.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).offset(-18)
        }
        
        contentView.addSubview(tempDay)
        tempDay.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).offset(-80)
        }
        
        contentView.addSubview(imageWeather)
        imageWeather.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(tempDay.snp.leading).offset(0)
            make.height.width.equalTo(70)
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: WeatherForecastDaily) {
        Task { NukeExtensions.loadImage(with: model.imageURL, into: imageWeather) }
        labelData.text = model.date
        tempDay.text = model.dayTemperature
        tempNight.text = model.nightTemperature
    }
}
