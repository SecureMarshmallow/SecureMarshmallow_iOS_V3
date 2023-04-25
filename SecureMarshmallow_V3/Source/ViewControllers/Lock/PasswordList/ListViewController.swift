//
//  ListViewController.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/04/07.
//

import SnapKit
import Then
import UIKit

final class ListViewController: UIViewController {
    private lazy var presenter = ListPresenter(viewController: self)
    
    private lazy var tableView = UITableView().then {
        $0.dataSource = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
}

extension ListViewController: ListProtocol {
    func setupNavigationBar() {
        navigationItem.title = "SecureMarshmallow"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapRightBarButtonItem))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func presentToWriteViewController() {
        let vc = UINavigationController(rootViewController: ReviewWriteViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    
}

private extension ListViewController {
    @objc func didTapRightBarButtonItem() {
        presenter.didTapRightBarButtonItem()
    }
}
