import UIKit

class TimeOfAppViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private lazy var presenter = TimeOfAppPresenter(viewController: self, navigationController: navigationController!)
    
    let tableView = UITableView()
    var times: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    // MARK: - Table view methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = times[indexPath.row]
        return cell
    }
    
}

extension TimeOfAppViewController: TimeOfAppProtocol {
    func dataFormatter() {
        if let savedTimes = UserDefaults.standard.stringArray(forKey: "times") {
            times = savedTimes
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentTime = formatter.string(from: Date())
        times.insert(currentTime, at: 0)
        UserDefaults.standard.set(times, forKey: "times")
        tableView.reloadData()
    }
    
    
    func tableViewSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    func navigationSetup() {
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "앱 열기 추적"
        self.navigationItem.largeTitleDisplayMode = .never
        
        let resetButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetButtonTap))
        
        navigationItem.rightBarButtonItem = resetButton
    }
    
    @objc func resetButtonTap() {
        let alert = UIAlertController(title: "알림", message: "앱 열기 추적을 초기화 하시겠습니까?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "초기화", style: .destructive) { _ in
            for key in UserDefaults.standard.dictionaryRepresentation().keys {
                UserDefaults.standard.removeObject(forKey: key.description)
            }
            
            self.tableView.reloadData()
        })

        alert.addAction(UIAlertAction(title: "취소", style: .default) { _ in
            print("취소")
        })
        
        // 화면에 표현
        present(alert, animated: true)
        tableView.reloadData()
    }
}

