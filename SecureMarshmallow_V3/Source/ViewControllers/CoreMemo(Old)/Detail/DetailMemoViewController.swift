//import UIKit
//import SnapKit
//import Then
//
//class DetailMemoViewController: UIViewController {
//    
//    var screenshotCount = 0
//    var screenshotTimestamps: [Date] = []
//    let dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm"
//        return formatter
//    }()
//        
//    private lazy var presenter = DetailMemoPresenter(viewController: self, navigationController: navigationController!)
//    
//    private var titleText: String?
//    private var contentsText: String?
//    
//    var navigationTitle: String = ""
//    
//    private lazy var contentsLabel = UILabel().then {
//        $0.font = .systemFont(ofSize: 16.0, weight: .medium)
//        $0.numberOfLines = 0
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        presenter.viewDidLoad()
//
//    }
//}
//
//extension DetailMemoViewController: DetailProtocol {
//    func screenshotDetection() {
//        let mainQueue = OperationQueue.main
//        
//        NotificationCenter.default.addObserver(
//            forName: UIApplication.userDidTakeScreenshotNotification,
//            object: nil,
//            queue: mainQueue)
//        {
//            [weak self] notification in
//            self?.screenshotCount += 1
//            
//            let timestamp = Date()
//            self?.screenshotTimestamps.append(timestamp)
//            
//            // UserDefaults에서 기존 데이터 가져오기
//            if let savedTimesData = UserDefaults.standard.data(forKey: "CaptureTimes"),
//               var savedTimes = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedTimesData) as? [Date] {
//                savedTimes.append(timestamp)
//                
//                // 데이터를 직렬화하여 UserDefaults에 저장
//                let encodedTimestamps = try? NSKeyedArchiver.archivedData(withRootObject: savedTimes, requiringSecureCoding: false)
//                UserDefaults.standard.set(encodedTimestamps, forKey: "CaptureTimes")
//            } else {
//                // 최초 데이터 저장
//                let encodedTimestamps = try? NSKeyedArchiver.archivedData(withRootObject: [timestamp], requiringSecureCoding: false)
//                UserDefaults.standard.set(encodedTimestamps, forKey: "CaptureTimes")
//            }
//                        
//            print("📸 스크린샷이 감지 되었습니다.")
//            print("✌️ 스크린샷 카운트: \(self?.screenshotCount ?? 0)")
//            if let formattedTimestamp = self?.dateFormatter.string(from: timestamp) {
//                print("캡처 시간: \(formattedTimestamp)")
//            }
//            
//            let alert = UIAlertController(title: "경고", message: "스크린샷이 감지 되었습니다.\n 스크린샷이 찍힌 시간을 (설정 -> 스크린샷 추적) 에 가시면 보실 수 있습니다.", preferredStyle: .alert)
//            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
//            alert.addAction(action)
//            self?.present(alert, animated: true, completion: nil)
//        }
//    }
//    
//    func displayMemo() {
//        contentsLabel.text = contentsText
//    }
//    
//    func setMemo(title: String, contents: String) {
//        navigationTitle = title
//        contentsText = contents
//    }
//    
//    func attribute() {
//        title = "\(navigationTitle)"
//
//        view.backgroundColor = .white
//    }
//    
//    func layout() {
//        view.addSubview(contentsLabel)
//        contentsLabel.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20.0)
//            $0.leading.trailing.equalToSuperview().inset(20.0)
//        }
//    }
//    
//}
