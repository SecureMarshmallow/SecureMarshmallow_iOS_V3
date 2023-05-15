//
//  ClockViewModel.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/14.
//

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
