//
//  MemoCollectionViewCell.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/19.
//

import UIKit
import SnapKit
import Then

class MemoCollectionViewCell: UICollectionViewCell {
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16.0, weight: .bold)
        $0.numberOfLines = 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5.0
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
