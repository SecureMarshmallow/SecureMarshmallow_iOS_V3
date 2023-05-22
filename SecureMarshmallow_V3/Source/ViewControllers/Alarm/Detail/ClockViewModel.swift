import Foundation
import UIKit

class ClockViewModel {
    let clock: Clock
    let collectionView: UICollectionView
    var today: Date

    init(clock: Clock, collectionView: UICollectionView) {
        self.clock = clock
        self.collectionView = collectionView
        today = Date.init()
    }
}
