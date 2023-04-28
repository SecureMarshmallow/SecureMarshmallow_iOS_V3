//
//  GmailItemType.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/04/28.
//
import UIKit

enum GmailItemType {
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

struct GmailItem: CommonItemType {
    typealias ItemType = GmailItemType
    
    let type: ItemType
    let hasSwitch: Bool
    var switchState: Bool
    
    init(type: ItemType, hasSwitch: Bool = false, switchState: Bool = false) {
        self.type = type
        self.hasSwitch = hasSwitch
        self.switchState = switchState
    }
}
