//
//  ReviewListPresenter.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/04/07.
//
import UIKit
//import Kingfisher

protocol ListProtocol{
    func setupNavigationBar()
    func setupViews()
    func presentToWriteViewController()
    func reloadTableView()
}

final class ListPresenter: NSObject {
    private let viewController: ListProtocol
    private let userDefaultManger = UserDefaultsManager()

    private var review: [SavePassword] = []
    
    init(viewController:
         ListProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupViews()
        
    }
    
    func viewWillAppear() {
        review = userDefaultManger.getReviews()
        viewController.reloadTableView()
    }
    
    func didTapRightBarButtonItem() {
        viewController.presentToWriteViewController()
    }
}

extension ListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        cell.textLabel?.text = "마쉬멜로 살리자"
        cell.detailTextLabel?.text = "열심히 열심히 하자"
        
        cell.selectionStyle = .none
        
        return cell
    }
}
