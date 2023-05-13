//
//  Persistable.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/13.
//

import Foundation

protocol Persistable{
    var uf: UserDefaults {get}
    var pk : String {get}
    func persist()
    func unpersist()
}
