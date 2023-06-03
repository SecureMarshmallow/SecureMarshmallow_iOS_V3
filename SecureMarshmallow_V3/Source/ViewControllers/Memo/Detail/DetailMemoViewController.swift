import UIKit
import SnapKit
import Then

class DetailMemoViewController: UIViewController {
    private lazy var presenter = DetailMemoPresenter(viewController: self, navigationController: navigationController!)
    
    private var titleText: String?
    private var contentsText: String?
    
    var navigationTitle: String = ""
    
    private lazy var contentsLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16.0, weight: .medium)
        $0.numberOfLines = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension DetailMemoViewController: DetailProtocol {
    func screenshotDetection() {
        let mainQueue = OperationQueue.main
        
        NotificationCenter.default.addObserver(
            forName: UIApplication.userDidTakeScreenshotNotification,
            object: nil,
            queue: mainQueue)
        {
            notification in
            let alert = UIAlertController(title: "경고", message: "스크린샷이 감지 되었습니다.\n 스크린샷이 찍힌 시간을 (설정 -> 스크린샷 추적) 에 가시면 보실 수 있습니다.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func displayMemo() {
        contentsLabel.text = contentsText
    }
    
    func setMemo(title: String, contents: String) {
        navigationTitle = title
        contentsText = contents
    }
    
    func attribute() {
        title = "\(navigationTitle)"

        view.backgroundColor = .white
    }
    
    func layout() {
        view.addSubview(contentsLabel)
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }
    }
    
}
