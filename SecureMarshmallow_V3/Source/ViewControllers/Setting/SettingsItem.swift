//
//  SettingsItem.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/04/10.
//
import Foundation

struct SettingsItem {
    let type: SettingsItemType
    let hasSwitch: Bool
    let switchState: Bool
    
    init(type: SettingsItemType, hasSwitch: Bool = false, switchState: Bool = false) {
        self.type = type
        self.hasSwitch = hasSwitch
        self.switchState = switchState
    }
}
