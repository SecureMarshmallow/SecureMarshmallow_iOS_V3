import UIKit

enum BagItemType {
    case IOSBag
    case BackendBag
    
    var title: String {
        switch self {
        case .IOSBag:
            return "iOS 버그"
        case .BackendBag:
            return "Backend 버그"
        }
    }
}

struct BagItem: CommonItemType {
    typealias ItemType = BagItemType
    
    let type: BagItemType
    let hasSwitch: Bool
    var switchState: Bool
    
    init(type: BagItemType, hasSwitch: Bool = false, switchState: Bool = false) {
        self.type = type
        self.hasSwitch = hasSwitch
        self.switchState = switchState
    }
}
