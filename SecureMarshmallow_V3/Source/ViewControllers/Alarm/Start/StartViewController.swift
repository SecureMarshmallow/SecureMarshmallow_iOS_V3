//
//  StartViewController.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/14.
//

import UIKit
import SnapKit
import Then

class StartController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
}
