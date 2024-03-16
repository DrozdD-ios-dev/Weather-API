//
//  SearchTableCell.swift
//  Weather
//
//  Created by Дрозд Денис on 04.03.2024.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {
    
    let regionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "AppleSDGothicNeo-light", size: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemGray5
//        contentView.isUserInteractionEnabled = true
        contentView.addSubview(regionLabel)
        regionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {  // изменить потом
        regionLabel.text = "Rostov"
    }
    
}
