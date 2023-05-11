//
//  FileViewController.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/12.
//

import UIKit
import Then
import SnapKit

class FileViewController: BaseEP {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWith(self)
        collectionView.dataSource = self
    }
    
    override func updateWith(_ controller: UIViewController) {
        super.updateWith(controller)
        
        nameLabel.text = "용량"
        customImageView.image = UIImage(named: "file")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
}
