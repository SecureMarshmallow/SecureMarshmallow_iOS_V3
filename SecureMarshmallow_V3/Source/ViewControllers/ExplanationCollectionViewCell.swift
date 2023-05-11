//
//  BatteryCollectionViewCell.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/11.
//

import SnapKit
import UIKit
import Kingfisher

class ExplanationCollectionViewCell: UICollectionViewCell {
    static var height: CGFloat { 70.0 }
    
    static let identifier = "ExplanationCollectionViewCell"

    var titleLabel = UILabel().then {
        $0.text = "안녕"
        $0.font = .systemFont(ofSize: 17.0, weight: .semibold)
        $0.textColor = .black
        $0.numberOfLines = 2
    }

     var descriptionLabel = UILabel().then {
         $0.text = "흐흐흐흐"
         $0.numberOfLines = 1
         $0.font = .systemFont(ofSize: 17.0, weight: .semibold)
         $0.textColor = .secondaryLabel
     }
    
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
