import UIKit
import SnapKit
import Then

class SupportViewController: BaseSV {
    
    private var supportItems: [[SupportItem]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSettingsItems()
    }
    
    override func attribute() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "지원"
    }
    
    override func configureItems() {
        tableView.register(SupportCell.self, forCellReuseIdentifier: SupportCell.reuseIdentifier)
    }
    
    private func configureSettingsItems() {
        let section1 = [SupportItem(type: .support)]
        
        supportItems = [section1]
    }
    
}

extension SupportViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supportItems[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SupportCell.reuseIdentifier, for: indexPath) as! SupportCell
        let item = supportItems[indexPath.section][indexPath.row]
        cell.configure(with: item)
        
        return cell
    }
}

extension SupportViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        let item = supportItems[indexPath.section][indexPath.row]
        switch item.type {
        case .support:
            print("지원")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return supportItems.count
    }
}
