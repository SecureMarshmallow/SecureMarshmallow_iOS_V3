//import UIKit
//import SnapKit
//import Then
//
//final class MemoListViewController: UIViewController {
//
//    var currentLongPressedCell: MemoCollectionViewCell?
//
//    private lazy var presenter = MemoListPresenter(viewController: self, navigationController: navigationController!)
//
//    private lazy var navLabel = UILabel().then {
//        $0.textColor = UIColor.black
//        $0.text = "메모"
//        $0.font = .systemFont(ofSize: 24.0, weight: .bold)
//    }
//
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .cellColor
//        collectionView.dataSource = presenter
//        collectionView.delegate = presenter
//        return collectionView
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        collectionView.register(MemoCollectionViewCell.self, forCellWithReuseIdentifier: MemoCollectionViewCell.reuseIdentifier)
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "AddCell")
//        presenter.viewDidLoad()
//        setupLongGestureRecognizerOnCollection()
//
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        presenter.viewWillAppear()
//    }
//}
//
//extension MemoListViewController: MemoListProtocol {
//    
//    func setupNavigationBar() {
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navLabel)
//        self.navigationItem.leftItemsSupplementBackButton = true
//    }
//
//    func setupViews() {
//        view.addSubview(collectionView)
//
//        collectionView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//    }
//
//    func presentToWriteViewController() {
//        let vc = UINavigationController(rootViewController: MemoWriteViewController())
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true)
//    }
//
//    func reloadCollectionView() {
//        collectionView.reloadData()
//    }
//
//    @objc func addImage() {
//        presenter.addNotes()
//    }
//
//    @objc private func didTapRightBarButtonItem() {
//        presenter.addNotes()
//    }
//}
//
//extension MemoListViewController: UIGestureRecognizerDelegate {
//    // long press 이벤트 부여
//    private func setupLongGestureRecognizerOnCollection() {
//
//        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
//        longPressedGesture.minimumPressDuration = 0.5
//        longPressedGesture.delegate = self
//        longPressedGesture.delaysTouchesBegan = true
//        collectionView.addGestureRecognizer(longPressedGesture)
//    }
//
//    // long press 이벤트 액션
//    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
//
//        let location = gestureRecognizer.location(in: gestureRecognizer.view)
//        let collectionView = gestureRecognizer.view as! UICollectionView
//
//        if gestureRecognizer.state == .began {
//
//            if let indexPath = collectionView.indexPathForItem(at: location) {
//                print("Long press at item began: \(indexPath.row)")
//
//                // animation
//                UIView.animate(withDuration: 0.2) {
//                    if let cell = collectionView.cellForItem(at: indexPath) as? MemoCollectionViewCell {
//                        self.currentLongPressedCell = cell
//                        cell.transform = .init(scaleX: 0.95, y: 0.95)
//                    }
//                }
//            }
//        } else if gestureRecognizer.state == .ended {
//
//            if let indexPath = collectionView.indexPathForItem(at: location) {
//                print("Long press at item end: \(indexPath.row)")
//
//                // animation
//                UIView.animate(withDuration: 0.2) {
//                    if let cell = self.currentLongPressedCell {
//                        cell.transform = .init(scaleX: 1, y: 1)
//
//                        if cell == collectionView.cellForItem(at: indexPath) as?
//                            MemoCollectionViewCell {
//
//                            let alertController = UIAlertController(title: "삭제", message: "정말로 삭제하기 겠습니까?\n삭제하면 복구할 수 없습니다", preferredStyle: .alert)
//
//                            let okAction = UIAlertAction(title: "삭제", style: .default) { (result: UIAlertAction) -> Void in
//                                UserDefaults.standard.removeObject(forKey: "AddCell")
//                            }
//
//                            let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (result: UIAlertAction) -> Void in
//                                print("Cancel")
//                            }
//
//                            alertController.addAction(cancelAction)
//                            alertController.addAction(okAction)
//                            self.present(alertController, animated: true, completion: nil)
//                        }
//                    }
//                }
//            }
//        } else {
//            return
//        }
//    }
//}
