import Foundation
import RealmSwift

extension Results {
  func toArray() -> [Element] {
    return compactMap {
        $0
    }
  }
}
