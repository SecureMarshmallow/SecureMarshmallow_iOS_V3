//
//  SupportPresenter.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/23.
//

import UIKit
import SnapKit
import Then

protocol SupportViewProtocol: AnyObject {
    func reloadTableView()
    func configureSettingsItems()
    func navigationSetup()
}

class SupportPresenter: NSObject {
    private let viewController: SupportViewProtocol?
    private let navigationController: UINavigationController
    
    init(viewController: SupportViewProtocol, navigationController: UINavigationController) {
        self.viewController = viewController
        self.navigationController = navigationController
    }
    
    func viewDidLoad() {
        viewController?.reloadTableView()
        viewController?.configureSettingsItems()
        viewController?.navigationSetup()
    }

}
