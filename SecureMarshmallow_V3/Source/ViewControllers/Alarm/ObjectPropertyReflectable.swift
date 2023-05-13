//
//  ObjectPropertyReflectable.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/13.
//

import Foundation

protocol ObjectPropertyReflectable {
    typealias RepresentationType = [String : Any]
    typealias ValuseType = [Any]
    typealias NameType = [String]
    
    var properrtyDictRepresentation: RepresentationType { get }
    var propertyValues: ValuseType { get }
    var propertyNames: NameType { get }
    static var propertyCount: Int { get }
    
    init(_ representationType: RepresentationType)
    
}

extension ObjectPropertyReflectable{
    
    var propertyDictRepresentation: RepresentationType {
        var ret: [String:Any] = [:]
        for case let (label, value) in Mirror(reflecting: self).children {
            guard let l = label else{
                continue
            }
            ret.updateValue(value, forKey: l)
        }
        return ret
    }
    
    var propertyValues: ValuseType {
        return Array(propertyDictRepresentation.values)
    }
    
    var propertyNames: NameType {
        return Array(propertyDictRepresentation.keys)
    }
}

