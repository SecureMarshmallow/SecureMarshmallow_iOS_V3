//
//  LockModel.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/04/27.
//

import Foundation

final class LockModel {
    
    let title: String
    let details: String?
    
    init(title: String, details: String?) {
        self.title = title
        self.details = details
    }
}
