//
//  BagCell.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/25.
//

import UIKit
import SnapKit
import Then

class BagCell: BaseSC<BagItem> {
    static let reuseIdentifier = "BagCell"
    
    override func configure(with item: BagItem) {
        super.configure(with: item)
        
        titleLabel.text = item.type.title
        switchControl.isOn = item.switchState
        switchControl.isHidden = !item.hasSwitch
    }
}
