import UIKit
import SnapKit

class DevelopersViewController: BaseVC {
    
    lazy var DevelopersTableView = UITableView().then {
        $0.register(DevelopersTableViewCell.self, forCellReuseIdentifier: DevelopersTableViewCell.className)
        $0.delegate = self
        $0.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "개발자 소개"
        DevelopersTableView.separatorStyle = .none
    }
    
    override func configureUI() {
        view.addSubview(DevelopersTableView)
        DevelopersTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.navigationItem.leftItemsSupplementBackButton = true
    }

    
}

extension DevelopersViewController: UITableViewDataSource, UITableViewDelegate {
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
