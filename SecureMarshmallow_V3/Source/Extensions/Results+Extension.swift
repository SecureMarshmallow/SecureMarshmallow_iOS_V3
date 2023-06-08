//
//  Results+Extension.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/06/08.
//

import Foundation
import RealmSwift

extension Results {
  func toArray() -> [Element] {
    return compactMap {
        $0
    }
  }
}
