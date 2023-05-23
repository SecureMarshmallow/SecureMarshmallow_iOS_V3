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
