import UIKit
import Then
import SnapKit

class AppLogoViewController: UIViewController {
    
    private lazy var presenter = AppLogoPresenter(viewController: self, navigationController: navigationController!)
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(AppLogoCell.self, forCellWithReuseIdentifier: AppLogoCell.identifier)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
}

extension AppLogoViewController: AppLogoProtocol {
    func layout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func attribute() {
        view.backgroundColor = .systemBackground

        collectionView.delegate = presenter
        collectionView.dataSource = presenter
        collectionView.reloadData()
    }
    
    func navigation() {
        title = "앱 로고 변경"
    }
}
