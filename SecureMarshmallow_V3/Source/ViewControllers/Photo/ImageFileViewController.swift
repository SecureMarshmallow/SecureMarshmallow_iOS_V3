import UIKit
import SnapKit
import Then

struct ImageCellData {
    let title: String
    let imageName: String
}

class ImageFileViewController: UIViewController {
    
    var imageCellData = [ImageCellData]()
    
    private lazy var navLabel = UILabel().then {
        $0.textColor = UIColor.black
        $0.text = "앨범"
        $0.font = .systemFont(ofSize: 24.0, weight: .bold)
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .cellColor
        $0.register(ImageFileCollectionViewCell.self, forCellWithReuseIdentifier: ImageFileCollectionViewCell.identifier)
    }
    
    var images = [UIImage]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: navLabel)
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "folder.fill.badge.plus"), style: .plain, target: self, action: #selector(showAddCellAlert))
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        loadImagesFromUserDefaults()
    }
    
    private func loadImagesFromUserDefaults() {
        if let imageDataArray = UserDefaults.standard.array(forKey: "ImageDataArray") as? [[String: Any]] {
            for imageData in imageDataArray {
                if let title = imageData["title"] as? String,
                   let imageName = imageData["imageName"] as? String {
                    let cellData = ImageCellData(title: title, imageName: imageName)
                    imageCellData.append(cellData)
                }
            }
        }
    }
    
    private func saveImagesToUserDefaults() {
        var imageDataArray = [[String: Any]]()
        for cellData in imageCellData {
            let imageData: [String: Any] = [
                "title": cellData.title,
                "imageName": cellData.imageName
            ]
            imageDataArray.append(imageData)
        }
        UserDefaults.standard.set(imageDataArray, forKey: "ImageDataArray")
    }
    
    @objc private func showAddCellAlert() {
        let alertController = UIAlertController(title: "Add Cell", message: "Enter a title for the new cell", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Title"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let textField = alertController.textFields?.first,
                  let title = textField.text else {
                return
            }
            
            let imageName = "image_\(self?.imageCellData.count ?? 0 + 1)"
            let newCellData = ImageCellData(title: title, imageName: imageName)
            self?.imageCellData.append(newCellData)
            
            let addedCellIndex = IndexPath(item: (self?.imageCellData.count ?? 0) - 1, section: 0)
            
            self?.collectionView.performBatchUpdates({
                self?.collectionView.insertItems(at: [addedCellIndex])
            }, completion: nil)
            
            self?.saveImagesToUserDefaults()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension ImageFileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCellData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageFileCollectionViewCell.identifier, for: indexPath) as! ImageFileCollectionViewCell
        
        let cellData = imageCellData[indexPath.item]
        cell.titleLabel.text = cellData.title
        cell.imageView.backgroundColor = .red
        cell.imageView.image = loadImage(named: cellData.imageName)
        
        return cell
    }
    
    private func loadImage(named imageName: String) -> UIImage? {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appendingPathComponent("\(imageName).png")
            return UIImage(contentsOfFile: fileURL.path)
        }
        return nil
    }
}

extension ImageFileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let spacing: CGFloat = 20
        let numberOfItemsPerRow: CGFloat = 2
        let itemWidth = (collectionViewWidth - spacing * (numberOfItemsPerRow + 1)) / numberOfItemsPerRow
        let itemHeight = itemWidth + 30
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellData = imageCellData[indexPath.item]
        let imageCollectionViewController = ImageCollectionViewController(cellData: cellData)
        navigationController?.pushViewController(imageCollectionViewController, animated: true)
    }
}
