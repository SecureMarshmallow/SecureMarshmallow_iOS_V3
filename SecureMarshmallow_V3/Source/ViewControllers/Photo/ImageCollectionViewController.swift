import UIKit
import SnapKit
import Then

struct ImageData {
    let imageName: String
    let imagePath: URL
}

class ImageCollectionViewController: UIViewController {
    
    private lazy var navLabel = UILabel().then {
        $0.textColor = UIColor.black
        $0.text = "앨범"
        $0.font = .systemFont(ofSize: 24.0, weight: .bold)
    }
    
    var screenshotCount = 0
    var screenshotTimestamps: [Date] = []
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
        
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .cellColor
        $0.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        $0.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "AddCell")
    }
    
    var cellData: ImageCellData
    var images = [ImageData]()
    var titleNavName: String = ""
    
    init(cellData: ImageCellData, navName: String) {
        self.cellData = cellData
        self.titleNavName = navName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .black
        
        navLabel.text = "앨범 / \(titleNavName)"
        
        let trashButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteSelectedImages))
        trashButton.isEnabled = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: navLabel)

        self.navigationItem.leftItemsSupplementBackButton = true
        
        navigationItem.rightBarButtonItems = [trashButton, UIBarButtonItem(image: UIImage(systemName: "folder.fill.badge.plus"), style: .plain, target: self, action: #selector(addImage))]

        
                        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        loadImages()
        screenshotDetection()
    }
    
    func screenshotDetection() {
        let mainQueue = OperationQueue.main
        
        NotificationCenter.default.addObserver(
            forName: UIApplication.userDidTakeScreenshotNotification,
            object: nil,
            queue: mainQueue)
        {
            [weak self] notification in
            self?.screenshotCount += 1
            
            let timestamp = Date()
            self?.screenshotTimestamps.append(timestamp)
            
            // UserDefaults에서 기존 데이터 가져오기
            if let savedTimesData = UserDefaults.standard.data(forKey: "CaptureTimes"),
               var savedTimes = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedTimesData) as? [Date] {
                savedTimes.append(timestamp)
                
                // 데이터를 직렬화하여 UserDefaults에 저장
                let encodedTimestamps = try? NSKeyedArchiver.archivedData(withRootObject: savedTimes, requiringSecureCoding: false)
                UserDefaults.standard.set(encodedTimestamps, forKey: "CaptureTimes")
            } else {
                // 최초 데이터 저장
                let encodedTimestamps = try? NSKeyedArchiver.archivedData(withRootObject: [timestamp], requiringSecureCoding: false)
                UserDefaults.standard.set(encodedTimestamps, forKey: "CaptureTimes")
            }
                        
            print("📸 스크린샷이 감지 되었습니다.")
            print("✌️ 스크린샷 카운트: \(self?.screenshotCount ?? 0)")
            if let formattedTimestamp = self?.dateFormatter.string(from: timestamp) {
                print("캡처 시간: \(formattedTimestamp)")
            }
            
            let alert = UIAlertController(title: "경고", message: "스크린샷이 감지 되었습니다.\n 스크린샷이 찍힌 시간을 (설정 -> 스크린샷 추적) 에 가시면 보실 수 있습니다.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    private func loadImages() {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURLs = try? FileManager.default.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
            if let fileURLs = fileURLs {
                for fileURL in fileURLs {
                    if fileURL.lastPathComponent.hasPrefix(cellData.imageName) {
                        if let image = UIImage(contentsOfFile: fileURL.path) {
                            images.append(ImageData(imageName: "\(cellData.imageName)_\(UUID().uuidString).png", imagePath: fileURL))
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
    
    @objc private func deleteSelectedImages() {
        guard let selectedItems = collectionView.indexPathsForSelectedItems else {
            return
        }
        
        let sortedItems = selectedItems.sorted { $0.item > $1.item }
        
        for indexPath in sortedItems {
            let imageData = images[indexPath.item]
            removeImageFromUserDefaults(imageName: imageData.imageName)
            removeImage(imagePath: imageData.imagePath)
            images.remove(at: indexPath.item)
        }
        
        collectionView.deleteItems(at: selectedItems)
//        navigationItem.rightBarButtonItems?.last?.isEnabled = false
    }
    
    private func removeImage(imagePath: URL) {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(at: imagePath)
        } catch {
            print("Error deleting image: \(error)")
        }
    }
    
    private func removeImageFromUserDefaults(imageName: String) {
        let userDefaults = UserDefaults.standard
        var imageKeys = userDefaults.stringArray(forKey: "ImageKeys") ?? []
        if let index = imageKeys.firstIndex(of: imageName) {
            imageKeys.remove(at: index)
            userDefaults.set(imageKeys, forKey: "ImageKeys")
        }
    }
    
    private func deleteImage(image: UIImage) {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURLs = try? FileManager.default.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
            if let fileURLs = fileURLs {
                for fileURL in fileURLs {
                    if let imageData = UIImage(contentsOfFile: fileURL.path),
                       imageData.isEqual(image) {
                        try? FileManager.default.removeItem(at: fileURL)
                        removeImageFromUserDefaults(imageURL: fileURL)
                    }
                }
            }
        }
    }
    
    private func removeImageFromUserDefaults(imageURL: URL) {
        if let imageName = imageURL.lastPathComponent.split(separator: "_").first {
            let userDefaults = UserDefaults.standard
            var imageKeys = userDefaults.stringArray(forKey: "ImageKeys") ?? []
            if let index = imageKeys.firstIndex(of: String(imageName)) {
                imageKeys.remove(at: index)
                userDefaults.set(imageKeys, forKey: "ImageKeys")
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
        let imageData = images[indexPath.row]
        cell.imageView.image = UIImage(contentsOfFile: imageData.imagePath.path)
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
            let imageData = saveImage(image)
            images.append(imageData)
        } else if let image = info[.originalImage] as? UIImage {
            let imageData = saveImage(image)
            images.append(imageData)
        }
        collectionView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    private func saveImage(_ image: UIImage) -> ImageData {
        var savedImageData: ImageData? = nil
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let imageName = "\(cellData.imageName)_\(UUID().uuidString).png"
            let fileURL = documentDirectory.appendingPathComponent(imageName)
            if let imageData = image.pngData() {
                try? imageData.write(to: fileURL)
                saveImageToUserDefaults(imageURL: fileURL)
                savedImageData = ImageData(imageName: imageName, imagePath: fileURL)
            }
        }
        return savedImageData ?? ImageData(imageName: "", imagePath: URL(fileURLWithPath: ""))
    }
    
    private func saveImageToUserDefaults(imageURL: URL) {
        if let imageName = imageURL.lastPathComponent.split(separator: "_").first {
            let userDefaults = UserDefaults.standard
            var imageKeys = userDefaults.stringArray(forKey: "ImageKeys") ?? []
            if !imageKeys.contains(String(imageName)) {
                imageKeys.append(String(imageName))
                userDefaults.set(imageKeys, forKey: "ImageKeys")
            }
        }
    }
}
