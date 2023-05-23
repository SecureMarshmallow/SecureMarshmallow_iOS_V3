//
//  GmailInformationPresenter.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/23.
//

import UIKit
import SnapKit

protocol GmailInformationProtocol: AnyObject {
    func attribute()
    func configureSettingsItems()
    func navigationSetup()
}

class GmailInformationPresenter: NSObject {
    private let viewController: GmailInformationProtocol
    private let navigationController: UINavigationController
    
    init(viewController: GmailInformationProtocol, navigationController: UINavigationController) {
        self.viewController = viewController
        self.navigationController = navigationController
    }
    
    func viewDidLoad() {
        viewController.attribute()
        viewController.configureSettingsItems()
        viewController.navigationSetup()
    }
    
}
