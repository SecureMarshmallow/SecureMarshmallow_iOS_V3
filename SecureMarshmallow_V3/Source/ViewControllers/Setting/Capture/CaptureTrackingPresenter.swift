//
//  CaptureTrackingPresenter.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/06/03.
//

import Foundation
import UIKit

protocol CaptureTrackingProtocol: AnyObject {
    func dataFormatter()
    func navigationSetup()
    func tableViewSetup()
    func resetButtonTap()
}

class CaptureTrackingPresenter: NSObject {
    private let viewController: CaptureTrackingProtocol
    private let navigationController: UINavigationController
    
    init(viewController: CaptureTrackingProtocol, navigationController: UINavigationController) {
        self.viewController = viewController
        self.navigationController = navigationController
    }
    
    func viewDidLoad() {
        viewController.tableViewSetup()
        viewController.dataFormatter()
        viewController.navigationSetup()
    }
}
