//
//  CommonItemType.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/04/29.
//

import UIKit

protocol CommonItemType {
    associatedtype ItemType
    var type: ItemType { get }
    var hasSwitch: Bool { get }
    var switchState: Bool { get set }
}
