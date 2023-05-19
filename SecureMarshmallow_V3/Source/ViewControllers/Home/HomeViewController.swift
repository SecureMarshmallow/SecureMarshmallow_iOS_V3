import UIKit
import Then

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private lazy var navLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "SecureMarshmallow"
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    var collectionView: UICollectionView!
    var items: [[Int]] = [
        [3, 1, 1, 1, 1, 2, 4, 4]
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
        collectionView.backgroundColor = .HomeBackgroundColor
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
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


    @objc func buttonTapped() {
        print("안녕")
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
        
        if item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SamilInformationCollectionViewCell.identifier, for: indexPath) as! SamilInformationCollectionViewCell
            cell.backgroundColor = .white
            cell.layout()
            cell.layer.cornerRadius = 25.0
            
            return cell
        } else if item == 4 {
            if indexPath.item == 6 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlarmCollectionViewCell.identifier, for: indexPath) as! AlarmCollectionViewCell
                cell.backgroundColor = .white
                cell.layout()
                cell.layer.cornerRadius = 20.0
                
                return cell
            } else if indexPath.item == 7 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LargeInformationCollectionViewCell.identifier, for: indexPath) as! LargeInformationCollectionViewCell
                cell.backgroundColor = .gray
                cell.layout()
                cell.layer.cornerRadius = 20.0
                
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
            cell.backgroundColor = .white
            
            let label = UILabel()
            label.font = .systemFont(ofSize: 20)
            label.textAlignment = .center
            label.textColor = .black
            label.text = "Item \(item)"
            cell.contentView.addSubview(label)
            label.snp.makeConstraints { make in
                make.edges.equalToSuperview()
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
        case 2:
            if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
                cellSize = CGSize(width: 370, height: 230)
            } else {
                cellSize = CGSize(width: 390, height: 230)
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

extension UIImage {
    func resized(toWidth width: CGFloat, height: CGFloat) -> UIImage? {
        let newSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func roundedImage(withRadius radius: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        let bounds = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: bounds, cornerRadius: radius).addClip()
        draw(in: bounds)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
