import UIKit
import SnapKit

class BagViewController: BaseSV {
    private lazy var presenter = BagPresenter(viewController: self, navigationController: navigationController!)
    
    private var bagItems: [[BagItem]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSettingsItems()
        presenter.viewDidLoad()
    }
    
    override func configureItems() {
        tableView.register(BagCell.self, forCellReuseIdentifier: BagCell.reuseIdentifier)
    }
}

extension BagViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bagItems[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BagCell.reuseIdentifier, for: indexPath) as! BagCell
        let item = bagItems[indexPath.section][indexPath.row]
        cell.configure(with: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        let item = bagItems[indexPath.section][indexPath.row]
        switch item.type {
        case .IOSBag:
            print("iOS 버그")
            let iOSWebVC = BagiOSWebViewController()
            iOSWebVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(iOSWebVC, animated: true)
        case .BackendBag:
            print("backend 버그")
            let backendWebVC = BagBackendWebViewController()
            backendWebVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(backendWebVC, animated: true)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return bagItems.count
    }
}

extension BagViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is BagViewController {
            navigationController.navigationBar.prefersLargeTitles = false
        } else {
            navigationController.navigationBar.prefersLargeTitles = true
        }
    }
}

extension BagViewController: BagProtocol {
    
    func configureSettingsItems() {
        let section1 = [BagItem(type: .IOSBag)]
        let section2 = [BagItem(type: .BackendBag)]
        bagItems = [section1, section2]
    }
    
    func navigationSetup() {
        navigationController?.delegate = self

        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "버그 제보"
    }
}
