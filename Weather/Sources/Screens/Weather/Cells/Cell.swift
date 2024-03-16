//
//  Cell.swift
//  Weather
//
//  Created by Дрозд Денис on 29.02.2024.
//

import UIKit
import NukeExtensions

protocol CollectionViewCellDelegate: AnyObject {
    
}

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "Cell"
    weak var delegate: CollectionViewCellDelegate?
    
    var labelTime: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    var labelTemp: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    var imageForecast: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(labelTime)
        labelTime.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(-21)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        contentView.addSubview(imageForecast)
        imageForecast.snp.makeConstraints { make in
            make.top.equalTo(labelTime.snp.bottom).offset(-5)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.width.equalTo(60)
        }
        
        contentView.addSubview(labelTemp)
        labelTemp.snp.makeConstraints { make in
            make.top.equalTo(imageForecast.snp.bottom).offset(-5)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func configure(with model: WeatherForecastHourly) {
        Task { NukeExtensions.loadImage(with: model.imageURL, into: imageForecast) }
        labelTime.text = model.date
        labelTemp.text = model.temperature
    }
    
}
