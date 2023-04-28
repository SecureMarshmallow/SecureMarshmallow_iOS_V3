//
//  AppLogoCell.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/04/28.
//

import UIKit
import SnapKit
import Then

class AppLogoCell: UICollectionViewCell {
    
    static var identifier = "AppLogoCell"
    
    var appLogoView = UIImageView().then {
        $0.backgroundColor = .red
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        contentView.addSubview(appLogoView)
        
        appLogoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
