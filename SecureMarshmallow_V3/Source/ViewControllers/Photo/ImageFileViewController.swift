//
//  ImageFileViewController.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/06/09.
//

import UIKit
import SnapKit
import Then

struct ImageCellData {
    let title: String
    let image: UIImage?
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
            
            let newCellData = ImageCellData(title: title, image: nil)
            self?.imageCellData.append(newCellData)
            
            let addedCellIndex = IndexPath(item: (self?.imageCellData.count ?? 0) - 1, section: 0)
            
            self?.collectionView.performBatchUpdates({
                self?.collectionView.insertItems(at: [addedCellIndex])
            }, completion: nil)
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
        
        if indexPath.row == 0 {
            cell.imageView.image = UIImage(named: "BlackLogo")
            cell.titleLabel.text = "메인 엘범"
            
        } else {
            cell.imageView.backgroundColor = .blue
            let cellData = imageCellData[indexPath.item]
            cell.titleLabel.text = cellData.title
        }
        
        return cell
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
}
