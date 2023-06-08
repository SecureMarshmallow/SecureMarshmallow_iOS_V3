import UIKit
import SnapKit
import Then

protocol MemoListProtocol {
    func setupNavigationBar()
    func setupViews()
    func presentToWriteViewController()
    func reloadCollectionView()
    func addImage()
}

final class MemoListPresenter: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private let viewController: MemoListProtocol
    private let userDefaultManger = UserDefaultsManager()
    private let navigationController: UINavigationController

    private let coreDataManager = CoreDataManager.shared

    private var tasks: [Task] = []

    private var review: [MemoData] = []

    init(viewController: MemoListProtocol, navigationController: UINavigationController) {
        self.viewController = viewController
        self.navigationController = navigationController
    }

    func viewDidLoad() {
        tasks = coreDataManager.fetchTasks()
        viewController.reloadCollectionView()
        viewController.setupNavigationBar()
        viewController.setupViews()
    }

    func viewWillAppear() {
        tasks = coreDataManager.fetchTasks()
        review = userDefaultManger.getReviews()
        viewController.reloadCollectionView()
    }

    func addNotes() {
        viewController.presentToWriteViewController()
    }
    
    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == tasks.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddCell", for: indexPath)
            let addButton = UIButton().then {
                $0.backgroundColor = .lightGray
                $0.setTitleColor(.white, for: .normal)
                $0.setTitle("+", for: .normal)
                $0.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
            }

            cell.contentView.addSubview(addButton)
            addButton.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            cell.layer.cornerRadius = 5
            cell.clipsToBounds = true
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemoCollectionViewCell.reuseIdentifier, for: indexPath) as! MemoCollectionViewCell
            let task = tasks[indexPath.item]
            cell.configure(title: task.title!)
            return cell
        }
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < tasks.count {
            let task = tasks[indexPath.row]
            let detailMemoViewController = DetailMemoViewController()
            detailMemoViewController.setMemo(title: task.title!, contents: task.details!)
            navigationController.pushViewController(detailMemoViewController, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let spacing: CGFloat = 20
        let numberOfItemsPerRow: CGFloat = 2
        let itemWidth = (collectionViewWidth - spacing * (numberOfItemsPerRow + 1)) / numberOfItemsPerRow

        return CGSize(width: itemWidth, height: itemWidth)
    }

    @objc private func didTapAddButton() {
        viewController.addImage()
    }
}
