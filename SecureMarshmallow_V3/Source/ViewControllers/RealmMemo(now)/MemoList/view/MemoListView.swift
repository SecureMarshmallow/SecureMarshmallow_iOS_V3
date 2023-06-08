//
//  ListView.swift
//  Pods
//
//  Created by 박준하 on 2023/06/08.
//

import UIKit
import SnapKit
import Then

class MemoListView: BaseView {

    lazy var tableView = UITableView(frame: .init(), style: .insetGrouped).then {
        $0.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }

    override func setupUI() { self.addSubview(tableView) }
    
    override func setConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
