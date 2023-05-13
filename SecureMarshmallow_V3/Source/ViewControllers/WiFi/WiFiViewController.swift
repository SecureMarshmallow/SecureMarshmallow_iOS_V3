//
//  WiFiViewController.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/12.
//

import UIKit
import SnapKit

class WiFiViewController: BaseEP {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWith(self)
    }
    
    override func updateWith(_ controller: UIViewController) {
        super.updateWith(controller)        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
}
