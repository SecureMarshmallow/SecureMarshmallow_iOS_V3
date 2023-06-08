import UIKit

class CaptureTrackingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private lazy var presenter = CaptureTrackingPresenter(viewController: self, navigationController: navigationController!)
    
    let tableView = UITableView()
    var times: [String] = []
//    let detailMemoViewController = DetailMemoViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = times[indexPath.row]
        return cell
    }
}

extension CaptureTrackingViewController: CaptureTrackingProtocol {
    
    func dataFormatter() {
        if let savedTimesData = UserDefaults.standard.data(forKey: "CaptureTimes") {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            
            if let savedTimes = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedTimesData) as? [Date] {
                times = savedTimes.map { formatter.string(from: $0) }
            } else {
                print("가져오기 실패했습니다")
                times = []
            }
        } else {
            print("빈 배열 입니다")
            times = []
        }
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
        title = "스크린샷 추적"
        self.navigationItem.largeTitleDisplayMode = .never
        
        let resetButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetButtonTap))
        
        navigationItem.rightBarButtonItem = resetButton
    }
    
    @objc func resetButtonTap() {
        let alert = UIAlertController(title: "알림", message: "스크린샷 추적을 초기화 하시겠습니까?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "초기화", style: .destructive) { _ in
            for key in UserDefaults.standard.dictionaryRepresentation().keys {
                UserDefaults.standard.removeObject(forKey: key.description)
            }
            
            self.times = []
            self.tableView.reloadData()
        })

        alert.addAction(UIAlertAction(title: "취소", style: .default) { _ in
            print("취소")
        })
        
        present(alert, animated: true)
    }

    
}
