import UIKit
import SnapKit
import Then

class DetailMemoViewController: UIViewController {
    private var titleText: String?
    private var contentsText: String?
    
    var navigationTitle: String = ""
    
    private lazy var contentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayMemo()
        
        title = "\(navigationTitle)"
        
        view.backgroundColor = .white
    }
    
    private func setupUI() {
        view.addSubview(contentsLabel)
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }
    }
    
    private func displayMemo() {
        contentsLabel.text = contentsText
    }
    
    func setMemo(title: String, contents: String) {
        navigationTitle = title
        contentsText = contents
    }
}
