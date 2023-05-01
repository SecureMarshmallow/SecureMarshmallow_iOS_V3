//
//  Extensions+NSObject.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/01.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
