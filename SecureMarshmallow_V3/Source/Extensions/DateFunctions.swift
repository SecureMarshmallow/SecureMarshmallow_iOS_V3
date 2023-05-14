//
//  DateFunctions.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/14.
//

import Foundation

extension DateComponents: Comparable {
    public static func < (lhs: DateComponents, rhs: DateComponents) -> Bool {
        let calendar = Calendar.current
        let lhsCmp = calendar.date(from: lhs)
        let rhsCmp = calendar.date(from: rhs)
        return (lhsCmp! < rhsCmp!)
    }
}

func toDateComponent(date: Date) -> DateComponents {
    return (Calendar.current.dateComponents([.year, .month, .day], from: date))
}
