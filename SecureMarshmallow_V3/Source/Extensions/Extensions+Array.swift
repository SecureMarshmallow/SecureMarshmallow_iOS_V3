//
//  Extensions+Array.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/14.
//

import Foundation

public extension Array {
    func safeRef (_ index: Int) -> Element? {
        return 0 <= index && index < count ? self[index] : nil
    }
}
