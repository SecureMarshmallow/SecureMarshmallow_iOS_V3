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
