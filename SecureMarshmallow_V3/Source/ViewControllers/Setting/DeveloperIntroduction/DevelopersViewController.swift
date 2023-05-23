import UIKit
import SnapKit

class DevelopersViewController: UIViewController {
    
    private lazy var presenter = DevelopersPresenter(viewController: self, navigationController: navigationController!)
    
    lazy var DevelopersTableView = UITableView().then {
        $0.register(DevelopersTableViewCell.self, forCellReuseIdentifier: DevelopersTableViewCell.className)
        $0.delegate = presenter
        $0.dataSource = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension DevelopersViewController: DevelopersProtocol {
    func layout() {
        view.addSubview(DevelopersTableView)
        DevelopersTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }
    
    func attribute() {
        DevelopersTableView.separatorStyle = .none
    }
    
    func navigation() {
        self.navigationItem.leftItemsSupplementBackButton = true
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "개발자 소개"
    }

}
