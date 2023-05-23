//
//  DevelopersPresenter.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/23.
//

import UIKit
import SnapKit
import Then

protocol DevelopersProtocol {
    func layout()
    func attribute()
}

final class DevelopersPresenter: NSObject  {
    private let viewController: DevelopersProtocol
    private let navigationController: UINavigationController
    
    init(viewController: DevelopersProtocol, navigationController: UINavigationController) {
        self.viewController = viewController
        self.navigationController = navigationController
    }
    
    func viewDidLoad() {
        viewController.layout()
        viewController.attribute()
    }
}

extension DevelopersPresenter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DevelopersTableViewCell.className, for: indexPath) as! DevelopersTableViewCell
        
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            cell.userImage.image = UIImage(named: "Junha")
            cell.nameLabel.text = "Junha park"
            cell.explanationLabel.text = "IOS Developer & backend"
            return cell

        case 1:
            cell.userImage.image = UIImage(named: "One")!
            cell.nameLabel.text = "Wonjun Do"
            cell.explanationLabel.text = "Backend security & Backend"
            return cell
            
        case 2:
            cell.userImage.image = UIImage(named: "Yang")
            cell.nameLabel.text = "Jieun Yang"
            cell.explanationLabel.text = "IOS security"
            return cell
            
        default:
            cell.nameLabel.text = "사용자가 없습니다"
            cell.explanationLabel.text = "아무것도 없습니다."
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
