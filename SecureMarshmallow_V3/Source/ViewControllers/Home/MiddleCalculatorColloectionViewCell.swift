//
//  MiddleCalculatorColloectionViewCell.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/25.
//

import UIKit
import SnapKit
import Then

class MiddleCalculatorColloectionViewCell: UICollectionViewCell {
    
    static let identifier = "MiddleCalculatorColloectionViewCell"
    
    var imageView = UIImageView().then {
        $0.image = UIImage(named: "calculatorImage")
    }
    
    public func layout() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.center.centerY.equalToSuperview()
            $0.height.width.equalTo(150)
        }
    }
}
