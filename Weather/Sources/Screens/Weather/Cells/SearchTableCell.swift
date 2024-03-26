//
//  SearchTableViewCell.swift
//  Weather
//
//  Created by Дрозд Денис on 04.03.2024.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        String(describing: self)
    }
    
    // MARK: - Views
    
    let regionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: EnumString.fontTwo.rawValue, size: EnumInt.sixteen)
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemGray5
        contentView.addSubview(regionLabel)
        regionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(EnumInt.sixteen)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
