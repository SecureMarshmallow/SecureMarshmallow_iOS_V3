//
//  BatteryPresenter.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/23.
//

import UIKit
import SnapKit
import Then

protocol BatteryProtocol: AnyObject {
    func batteryState()
    func batteryNotification()
    func navigationSetup()
}

class BatteryPresenter: NSObject {
    private let viewController: BatteryProtocol
    private let navigationController: UINavigationController
    
    init(viewController: BatteryProtocol, navigationController: UINavigationController) {
        self.viewController = viewController
        self.navigationController = navigationController
    }
    
    func updateWiths() {
        viewController.batteryState()
        viewController.batteryNotification()
        viewController.navigationSetup()
    }
}
