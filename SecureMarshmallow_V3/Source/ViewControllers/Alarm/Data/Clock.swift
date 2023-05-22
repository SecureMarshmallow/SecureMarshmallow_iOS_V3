import Foundation

struct Clock: Codable, Identifiable, Hashable {
    var id: UUID
    var name: String
    var daysOfWeek: [Int]
    var ringDays: [DateComponents]
    var isActivated: Bool
    var ringTime: DateComponents
    var notificationId: String
    var selectedDays: [Bool]
    var selectedRingtone: [Bool]
}
