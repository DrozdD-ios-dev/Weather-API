//
//  WeatherDescriptionLabel.swift
//  Weather
//
//  Created by Дрозд Денис on 01.03.2024.
//

import UIKit

final class WeatherDescriptionLabel: UILabel {
    convenience init(size: CGFloat) {
        self.init(frame: .zero)
        font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: size)
        textColor = .white
    }
}
