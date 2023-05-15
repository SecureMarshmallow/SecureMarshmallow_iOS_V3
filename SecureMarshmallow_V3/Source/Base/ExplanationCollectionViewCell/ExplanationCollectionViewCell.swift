//
//  BatteryCollectionViewCell.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/11.
//

import UIKit

class ExplanationCollectionViewCell: UICollectionViewCell {
    static var height: CGFloat { 70.0 }
    
    static let identifier = "ExplanationCollectionViewCell"

    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "안녕"
        label.font = .systemFont(ofSize: 17.0, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 2
        
        return label
    }()

    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "흐흐흐흐"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17.0, weight: .semibold)
        label.textColor = .secondaryLabel
        return label
     }()
    
    public func layout() {
        
        [
            titleLabel,
            descriptionLabel
        ].forEach { contentView.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10.0)
            $0.left.equalToSuperview().offset(15.0)
        }

        descriptionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20.0)
        }
    }
}
