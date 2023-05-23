import UIKit
import SnapKit

class GmailInformationViewController: BaseSV {
    private lazy var presenter = GmailInformationPresenter(viewController: self, navigationController: navigationController!)
    
    private var gmailItems: [[GmailItem]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSettingsItems()
        presenter.viewDidLoad()
    }

    override func configureItems() {
        tableView.register(GmailCell.self, forCellReuseIdentifier: GmailCell.reuseIdentifier)
    }
    
}

// MARK: - UITableViewDataSource

extension GmailInformationViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gmailItems[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GmailCell.reuseIdentifier, for: indexPath) as! GmailCell
        let item = gmailItems[indexPath.section][indexPath.row]
        cell.configure(with: item)
        
        if indexPath.row == 0 {
            cell.titleLabel.textColor = .red
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension GmailInformationViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        let item = gmailItems[indexPath.section][indexPath.row]
        switch item.type {
        case .restoreEmail:
            print("복구 이메일")
        case .deleteAccount:
            print("계정 삭제")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return gmailItems.count
    }
}

extension GmailInformationViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is GmailInformationViewController {
            navigationController.navigationBar.prefersLargeTitles = false
        } else {
            navigationController.navigationBar.prefersLargeTitles = true
        }
    }
}

extension GmailInformationViewController: GmailInformationProtocol {
    
    func configureSettingsItems() {
        let section1 = [GmailItem(type: .restoreEmail)]
        let section2 = [GmailItem(type: .deleteAccount)]
        gmailItems = [section1, section2]
    }
    
    func navigationSetup() {
        navigationController?.delegate = self

        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "gmail 정보"
    }
}
