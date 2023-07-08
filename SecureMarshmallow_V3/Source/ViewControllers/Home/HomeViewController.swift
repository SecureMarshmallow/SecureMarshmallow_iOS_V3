import UIKit
import CryptoKit
import Then
import IOSSecuritySuite

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let secretKey = SymmetricKey(size: .bits256)
    
    private lazy var navLabel = UILabel().then {
        $0.textColor = UIColor.black
        $0.text = "SecureMarshmallow"
        $0.font = .systemFont(ofSize: 24.0, weight: .bold)
    }
    
    var collectionView: UICollectionView!
    var items: [[Double]] = [
        [3, 1, 1.1, 1.2, 1.3, 2, 6, 7.1, 7.2, 7.3]
    ]
    
    let cellIdentifier = "cell"
    var movingCellSnapshot: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                    
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 24, left: 20, bottom: 24, right: 20)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(SamilInformationCollectionViewCell.self, forCellWithReuseIdentifier: SamilInformationCollectionViewCell.identifier)
        collectionView.register(LargeInformationCollectionViewCell.self, forCellWithReuseIdentifier: LargeInformationCollectionViewCell.identifier)
        collectionView.register(AlarmCollectionViewCell.self, forCellWithReuseIdentifier: AlarmCollectionViewCell.identifier)
        collectionView.register(MiddleCalculatorColloectionViewCell.self, forCellWithReuseIdentifier: MiddleCalculatorColloectionViewCell.identifier)
        collectionView.register(LargeBluetoothCollectionViewCell.self, forCellWithReuseIdentifier: LargeBluetoothCollectionViewCell.identifier)
        collectionView.register(ShhCollectionViewCell.self, forCellWithReuseIdentifier: ShhCollectionViewCell.identifier)
        collectionView.register(TimerCollectionViewCell.self, forCellWithReuseIdentifier: TimerCollectionViewCell.identifier)
        collectionView.register(HMACViewController.self, forCellWithReuseIdentifier: HMACViewController.identifier)
        collectionView.register(CacheClearCollectionViewCell.self, forCellWithReuseIdentifier: CacheClearCollectionViewCell.identifier)

        collectionView.backgroundColor = .HomeBackgroundColor
        view.addSubview(collectionView)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
        
//        edgesForExtendedLayout = []
        
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        collectionView.makeSecure()
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(_:)))
        collectionView.addGestureRecognizer(longPressGesture)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureUI()
    }
    
    func configureUI() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navLabel)
        self.navigationItem.leftItemsSupplementBackButton = true
        
        let image = UIImage(named: "AppIcon")
        
        let resizedImage = image?.resized(toWidth: 50, height: 50)
        
        let roundedImage = resizedImage?.roundedImage(withRadius: 25)
        
        let button = UIButton(type: .custom)
        button.setImage(roundedImage, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 20
        
        navigationItem.rightBarButtonItems = [spacer, barButtonItem]
    }

    private func clearCache() {
        let cache = URLCache.shared
        cache.removeAllCachedResponses()
        print(cache)
        print("Cache is cleared!")
    }

    @objc func buttonTapped() {
        print("마쉬멜로~~야아아ㅏ")
        let modalViewController = AddMainCollectionViewController()
        self.present(modalViewController, animated: true)
    }

    
    @objc func handleLongGesture(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)

            let cell = collectionView.cellForItem(at: selectedIndexPath)!
            
            movingCellSnapshot = cell.snapshotView(afterScreenUpdates: false)
            movingCellSnapshot?.center = cell.center
            collectionView.addSubview(movingCellSnapshot!)
            cell.isHidden = true
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
            movingCellSnapshot?.center = gesture.location(in: collectionView)
        case .ended:
            collectionView.endInteractiveMovement()
            if let snapshot = movingCellSnapshot {
                snapshot.removeFromSuperview()
            }
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
                collectionView.cellForItem(at: selectedIndexPath)?.isHidden = false
            }
        default:
            collectionView.cancelInteractiveMovement()
            if let snapshot = movingCellSnapshot {
                snapshot.removeFromSuperview()
            }
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
                collectionView.cellForItem(at: selectedIndexPath)?.isHidden = false
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = .cellColor
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let item = items[indexPath.section][indexPath.item]
        
        switch item {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SamilInformationCollectionViewCell.identifier, for: indexPath) as! SamilInformationCollectionViewCell
            cell.setImage(image: UIImage(named: "iPhone"))
            cell.layout()
            return cell
        case 1.1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SamilInformationCollectionViewCell.identifier, for: indexPath) as! SamilInformationCollectionViewCell
            cell.setImage(image: UIImage(named: "battery"))
            return cell
        case 1.2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SamilInformationCollectionViewCell.identifier, for: indexPath) as! SamilInformationCollectionViewCell
            cell.setImage(image: UIImage(named: "file"))
            return cell
        case 1.3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SamilInformationCollectionViewCell.identifier, for: indexPath) as! SamilInformationCollectionViewCell
            cell.setImage(image: UIImage(named: "WiFi"))
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShhCollectionViewCell.identifier, for: indexPath) as! ShhCollectionViewCell
            return cell
            
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimerCollectionViewCell.identifier, for: indexPath) as! TimerCollectionViewCell
            
            return cell
        case 6:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MiddleCalculatorColloectionViewCell.identifier, for: indexPath) as! MiddleCalculatorColloectionViewCell
            cell.backgroundColor = .white
            cell.layout()
            cell.layer.cornerRadius = 25.0
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlarmCollectionViewCell.identifier, for: indexPath) as! AlarmCollectionViewCell
            cell.backgroundColor = .white
            cell.layout()
            cell.layer.cornerRadius = 20.0
            return cell
        case 7:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MiddleAlamCollectionViewCell.identifier, for: indexPath) as! MiddleAlamCollectionViewCell
            cell.backgroundColor = .white
            cell.layout()
            return cell
        case 7.1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlarmCollectionViewCell.identifier, for: indexPath) as! AlarmCollectionViewCell
            cell.backgroundColor = .white
            cell.layout()
            cell.layer.cornerRadius = 20.0
            return cell
        case 7.2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HMACViewController.identifier, for: indexPath) as! HMACViewController
            let isTampered = indexPath.item % 2 == 1
            let message = isTampered ? "This is a tampered message." : "This is the original message."
            if isTampered == true {
                cell.setupImageView(UIImage(named: "bad")!)
                cell.resultLabelTextColor(.red)
            } else {
                cell.setupImageView(UIImage(named: "good")!)
                cell.resultLabelTextColor(.green)
            }
            let hmac = HMAC<SHA256>.authenticationCode(for: Data(message.utf8), using: secretKey)
            cell.verifyMessage(isTampered: isTampered, hmac: hmac, secretKey: secretKey)
            return cell
            
        case 7.3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CacheClearCollectionViewCell.identifier, for: indexPath) as! CacheClearCollectionViewCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
            cell.backgroundColor = .white

            let label = UILabel()
            label.font = .systemFont(ofSize: 20)
            label.textAlignment = .center
            label.textColor = .black
            label.text = "Item \(item)"
            cell.contentView.addSubview(label)
            
            label.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            return cell
        }
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard indexPath.section < items.count, indexPath.item < items[indexPath.section].count else {
            return .zero
        }
        
        let item = items[indexPath.section][indexPath.item]
        var cellSize = CGSize.zero
        
        switch item {
        case 1:
            cellSize = CGSize(width: 80, height: 80)
        case 1.1:
            cellSize = CGSize(width: 80, height: 80)
        case 1.2:
            cellSize = CGSize(width: 80, height: 80)
        case 1.3:
            cellSize = CGSize(width: 80, height: 80)
        case 2:
            if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
                cellSize = CGSize(width: 370, height: 160)
            } else {
                cellSize = CGSize(width: 390, height: 160)
            }
        case 3:
            if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
                cellSize = CGSize(width: 370, height: 160)
            } else {
                cellSize = CGSize(width: 390, height: 190)
            }
        case 4:
            cellSize = CGSize(width: 150, height: 150)
        case 5:
            if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
                cellSize = CGSize(width: 370, height: 370)
            } else {
                cellSize = CGSize(width: 390, height: 390)
            }
        case 6:
            cellSize = CGSize(width: 180, height: 180)
        case 7:
            cellSize = CGSize(width: 180, height: 180)
        case 7.1:
            cellSize = CGSize(width: 180, height: 180)
        case 7.2:
            cellSize = CGSize(width: 180, height: 180)
        case 7.3:
            cellSize = CGSize(width: 180, height: 180)
        default:
            break
        }
        
        return cellSize
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 20, bottom: 24, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: screenWidth, height: 10)
    }
    
}

extension HomeViewController {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.section][indexPath.item]
        
        switch item {
        case 1:
            let vc = OSViewController()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        case 1.1:
            let vc = BatteryViewController()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        case 1.2:
            let vc = FileViewController()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        case 1.3:
            let vc = WiFiViewController()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        case 6:
            let calculatorVC = CalculatorViewController()
            calculatorVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(calculatorVC, animated: true)
        case 7.1:
            let alarmVC = StartController()
            alarmVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(alarmVC, animated: true)
        case 7.3:
            let sheet = UIAlertController(title: "캐시", message: "캐시를 전부 삭제하시겠습니까?", preferredStyle: .actionSheet)

            sheet.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
                self.clearCache() }))

            sheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { _ in print("취소") }))

            present(sheet, animated: true)
        default:
            print("클릭되지 않음")
        }

        print("Selected item: \(item)")
        print(items)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {

        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = items[sourceIndexPath.section].remove(at: sourceIndexPath.item)
        items[destinationIndexPath.section].insert(item, at: destinationIndexPath.item)
        
        if sourceIndexPath.section == destinationIndexPath.section {

            collectionView.reloadSections([sourceIndexPath.section])
        } else {

            collectionView.reloadSections([sourceIndexPath.section, destinationIndexPath.section])
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {

        let adjustedIndexPath = IndexPath(item: (collectionView.numberOfItems(inSection: proposedIndexPath.section) / 2), section: proposedIndexPath.section)
        
        return adjustedIndexPath
    }
}
