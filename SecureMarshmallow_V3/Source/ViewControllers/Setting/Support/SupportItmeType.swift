import UIKit

enum SupportItemType {
    case support
    
    var title: String {
        switch self {
            
        case .support:
            return "카카오뱅크 7777-01-5832634"
        }
    }
}

struct SupportItem: CommonItemType {
    typealias ItemType = SupportItemType
    
    let type: ItemType
    let hasSwitch: Bool
    var switchState: Bool
    
    init(type: ItemType, hasSwitch: Bool = false, switchState: Bool = false) {
        self.type = type
        self.hasSwitch = hasSwitch
        self.switchState = switchState
    }
}
