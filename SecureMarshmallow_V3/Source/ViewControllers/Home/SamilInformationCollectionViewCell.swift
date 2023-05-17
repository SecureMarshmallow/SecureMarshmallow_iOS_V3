//
//  InformationCollectionViewCell.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/17.
//

import UIKit
import SnapKit
import Then

class SamilInformationCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SamilInformationCollectionViewCell"
    
    var imageView: UIImageView = {
        let images = UIImageView()
        images.image = UIImage(named: "3Dlock")
       
        return images
    }()
    
    public func layout() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(50.0)
        }
    }
}
