//
//  EditButton.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/15.
//

import UIKit

class EditButton: UIButton {
    
    init(title: String, backgroundColor: UIColor = .cellColor, font: UIFont? = UIFont.systemFont(ofSize: 15, weight: .bold)) {
        let frame = CGRect(x: 0, y: 0, width: 370, height: 60)
        super.init(frame: frame)
        
        self.backgroundColor = backgroundColor
        setTitleColor(.cellTitleColor, for: .normal)
        
        layer.cornerRadius = 20
        layer.borderColor = UIColor.white.cgColor
        
        layer.shadowOffset = CGSize(width: 10, height: 10)
        layer.shadowOpacity = 0.1
        
        setTitle(title, for: .normal)
        titleLabel?.font = font
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
