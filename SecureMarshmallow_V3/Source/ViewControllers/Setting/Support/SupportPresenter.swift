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
}

class SupportPresenter: NSObject {
    weak var viewController: SupportViewProtocol?
    
    private var supportItems: [[SupportItem]] = []
    
    init(viewController: SupportViewProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.reloadTableView()
        viewController?.configureSettingsItems()
    }

}
