import UIKit
import SnapKit
import Then

class ImageCollectionViewController: UIViewController {
    
    private lazy var navLabel = UILabel().then {
        $0.textColor = UIColor.black
        $0.text = "앨범"
        $0.font = .systemFont(ofSize: 24.0, weight: .bold)
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .cellColor
        $0.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        $0.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "AddCell")
    }
    
    var cellData: ImageCellData
    var images = [UIImage]()
    
    init(cellData: ImageCellData) {
        self.cellData = cellData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: navLabel)
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "folder.fill.badge.plus"), style: .plain, target: self, action: #selector(addImage))
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        loadImages()
    }
    
    private func loadImages() {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURLs = try? FileManager.default.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
            if let fileURLs = fileURLs {
                for fileURL in fileURLs {
                    if fileURL.lastPathComponent.hasPrefix(cellData.imageName) {
                        if let image = UIImage(contentsOfFile: fileURL.path) {
                            images.append(image)
                        }
                    }
                }
            }
        }
    }

    @objc func addImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    private func saveImage(_ image: UIImage) {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appendingPathComponent("\(cellData.imageName)_\(UUID().uuidString).png")
            if let imageData = image.pngData() {
                try? imageData.write(to: fileURL)
            }
        }
    }
}

extension ImageCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = images[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let image = images.remove(at: sourceIndexPath.row)
        images.insert(image, at: destinationIndexPath.row)
    }
}

extension ImageCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        navigationItem.rightBarButtonItem?.isEnabled = true
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if collectionView.indexPathsForSelectedItems?.count == 0 {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}

extension ImageCollectionViewController: UICollectionViewDelegateFlowLayout {
    
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
}

extension ImageCollectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            saveImage(image)
            images.append(image)
        } else if let image = info[.originalImage] as? UIImage {
            saveImage(image)
            images.append(image)
        }
        collectionView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}

