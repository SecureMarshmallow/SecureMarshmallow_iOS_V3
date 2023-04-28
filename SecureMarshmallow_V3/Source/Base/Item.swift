//
//  Item.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/04/29.
//

import UIKit
import Foundation

struct Item<T> {
    let type: T
    let hasSwitch: Bool
    let switchState: Bool
    
    init(type: T, hasSwitch: Bool = false, switchState: Bool = false) {
        self.type = type
        self.hasSwitch = hasSwitch
        self.switchState = switchState
    }
}
