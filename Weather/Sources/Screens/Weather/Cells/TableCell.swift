//
//  TableViewCell.swift
//  Weather
//
//  Created by Дрозд Денис on 29.02.2024.

import UIKit
import NukeExtensions

final class TableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        String(describing: self)
    }
    
    // MARK: - Views
    
   private var tempDay: UILabel = {
        let label = UILabel()
        label.textColor = .black
       label.font = UIFont(name: EnumString.fontTwo.rawValue, size: EnumInt.twentyFive)
        return label
    }()
    
    private var tempNight: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont(name: EnumString.fontTwo.rawValue, size: EnumInt.twentyFive)
        return label
    }()
    
    private var labelData: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: EnumString.fontTwo.rawValue, size: EnumInt.twentyFive)
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
        
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    
    func configure(with model: WeatherForecastDaily) {
        Task { NukeExtensions.loadImage(with: model.imageURL, into: imageWeather) }
        labelData.text = model.date
        tempDay.text = model.dayTemperatureN
        tempNight.text = model.nightTemperatureN
    }
    
    // MARK: - Layout
    
    private func addSubviews() {
        contentView.addSubview(labelData)
        contentView.addSubview(tempNight)
        contentView.addSubview(tempDay)
        contentView.addSubview(imageWeather)
    }
    
    private func makeConstraints() {
        labelData.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(contentView.frame.width * 0.05)
        }
        
        tempNight.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).inset(contentView.frame.width * 0.07)
        }
        
        tempDay.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).inset(contentView.frame.width * 0.25)
        }
        
        imageWeather.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(contentView.frame.width * 0.42)
            make.height.width.equalTo(contentView.frame.height * 1.5)
            
        }
    }
}
