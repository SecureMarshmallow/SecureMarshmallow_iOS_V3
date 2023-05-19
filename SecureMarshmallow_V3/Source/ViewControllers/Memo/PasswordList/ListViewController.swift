import UIKit
import SnapKit
import Then

final class ListViewController: UIViewController {
    private lazy var presenter = ListPresenter(viewController: self)

    private lazy var navLabel = UILabel().then {
        $0.textColor = UIColor.black
        $0.text = "메모"
        $0.font = .systemFont(ofSize: 24.0, weight: .bold)
    }

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = presenter
        collectionView.delegate = presenter
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(TaskCollectionViewCell.self, forCellWithReuseIdentifier: TaskCollectionViewCell.reuseIdentifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "AddCell")
        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.viewWillAppear()
    }
}

extension ListViewController: ListProtocol {
    func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navLabel)
        self.navigationItem.leftItemsSupplementBackButton = true

//        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addImage))
//        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    func setupViews() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func presentToWriteViewController() {
        let vc = UINavigationController(rootViewController: ReviewWriteViewController())
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
