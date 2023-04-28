//
//  ViewController2.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/04/28.
//

import UIKit
import SnapKit
import CoreData

class Image: NSManagedObject {
    @NSManaged public var dateAdded: Date?
    @NSManaged public var data: Data?
}

class ViewController2: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var images = [Image]()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.bottom.equalToSuperview()
        }
        
        fetchData()
    }
    
    func fetchData() {
        let request: NSFetchRequest<Image> = NSFetchRequest<Image>(entityName: "Image")
        let sortDescriptor = NSSortDescriptor(key: "dateAdded", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        do {
            images = try context.fetch(request)
            collectionView.reloadData()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func saveImage(imageData: Data) {
        let image = Image(context: context)
        image.dateAdded = Date()
        image.data = imageData
        do {
            try context.save()
            images.append(image)
            collectionView.reloadData()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension ViewController2: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        let image = images[indexPath.row]
        cell.imageView.image = UIImage(data: image.data ?? Data())
        cell.titleLabel.text = "\(indexPath.row + 1)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.bounds.width - 24) / 3
        return CGSize(width: itemWidth, height: itemWidth * 1.3 + 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Image Options", message: nil, preferredStyle: .actionSheet)
        
        let image = images[indexPath.row]
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.context.delete(image)
            do {
                try self.context.save()
                self.images.remove(at: indexPath.row)
                self.collectionView.deleteItems(at: [indexPath])
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

class ImageCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(imageView.snp.width).multipliedBy(1.3)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
