//
//  AppLogoItemType.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/04/28.
//

import UIKit

enum AppLogoItemType {
    case restoreEmail
    case deleteAccount
    
    var title: String {
        switch self {
        case .restoreEmail:
            return "복구 이메일"
        case .deleteAccount:
            return "계정 삭제"
        }
    }
}

struct AppLogoItem {
    let type: GmailItemType
    let hasSwitch: Bool
    let switchState: Bool
    
    init(type: GmailItemType, hasSwitch: Bool = false, switchState: Bool = false) {
        self.type = type
        self.hasSwitch = hasSwitch
        self.switchState = switchState
    }
}
