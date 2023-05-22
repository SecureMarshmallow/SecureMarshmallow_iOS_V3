import UIKit
import SnapKit
import Then

final class MemoListViewController: UIViewController {
    private lazy var presenter = MemoListPresenter(viewController: self, navigationController: navigationController!)

    private lazy var navLabel = UILabel().then {
        $0.textColor = UIColor.black
        $0.text = "메모"
        $0.font = .systemFont(ofSize: 24.0, weight: .bold)
    }

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .cellColor
        collectionView.dataSource = presenter
        collectionView.delegate = presenter
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(MemoCollectionViewCell.self, forCellWithReuseIdentifier: MemoCollectionViewCell.reuseIdentifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "AddCell")
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.viewWillAppear()
    }
}

extension MemoListViewController: MemoListProtocol {
    func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navLabel)
        self.navigationItem.leftItemsSupplementBackButton = true
    }

    func setupViews() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func presentToWriteViewController() {
        let vc = UINavigationController(rootViewController: MemoWriteViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

    func reloadCollectionView() {
        collectionView.reloadData()
    }

    @objc func addImage() {
        presenter.addNotes()
    }

    @objc private func didTapRightBarButtonItem() {
        presenter.addNotes()
    }
}
