import UIKit

protocol CommonItemType {
    associatedtype ItemType
    var type: ItemType { get }
    var hasSwitch: Bool { get }
    var switchState: Bool { get set }
}
