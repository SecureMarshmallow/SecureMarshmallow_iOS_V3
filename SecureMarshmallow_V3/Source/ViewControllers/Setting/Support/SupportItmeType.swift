//
//  SupportItmeType.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/04/29.
//

import UIKit

enum SupportItemType {
    case support
    
    var title: String {
        switch self {
            
        case .support:
            return "지원"
        }
    }
}

struct SupportItem: CommonItemType {
    typealias ItemType = SupportItemType
    
    let type: ItemType
    let hasSwitch: Bool
    var switchState: Bool
    
    init(type: ItemType, hasSwitch: Bool = false, switchState: Bool = false) {
        self.type = type
        self.hasSwitch = hasSwitch
        self.switchState = switchState
    }
}
