//
//  ImageCollectionViewCell.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/03.
//
import UIKit
import SnapKit
import Then

class ImageCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
