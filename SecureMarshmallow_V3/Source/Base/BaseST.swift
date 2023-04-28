//import UIKit
//
//class BaseST: UIViewController {
//    
//    private let tableView = UITableView(frame: .zero, style: .grouped)
//    
//    var items: [[SettingsItem]] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//    }
//    
//    func configureUI() {
//        view.backgroundColor = .systemBackground
//        navigationItem.title = ""
//        
//    }
//    
//    func configureTableView() {
//        view.addSubview(tableView)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)
//        tableView.tableFooterView = UIView()
//        tableView.separatorStyle = .none
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            make.leading.equalTo(view.snp.leading)
//            make.trailing.equalTo(view.snp.trailing)
//            make.bottom.equalTo(view.snp.bottom)
//        }
//    }
//}
//
//extension BaseST: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return UIView()
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return items.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return items[section].count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseIdentifier, for: indexPath) as! SettingsCell
//        let item = items[indexPath.section][indexPath.row]
//        cell.configure(with: item)
//        return cell
//    }
//}
//
//extension BaseST: UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 15
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
//
//}
