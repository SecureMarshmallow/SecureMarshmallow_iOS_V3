//
//  BatteryViewController.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/11.
//

import UIKit
import SnapKit
import Then

class BatteryViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 60.0
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 30.0, bottom: 10.0, right: 30.0)

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .BackGray
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = true
        
        collectionView.register(
            BatteryCollectionViewCell.self,
            forCellWithReuseIdentifier: BatteryCollectionViewCell.identifier
        )

        return collectionView
    }()
    
//    let reuseIdentifier = "cell"

    private lazy var batteryImageView = UIImageView().then {
        $0.image = UIImage(named: "Battery")
    }

    private lazy var backgroundView = UIView().then {
        $0.backgroundColor = .BackGray
        $0.addSubview(collectionView)
    }

    private lazy var nameLabel = UILabel().then {
        $0.text = "배터리"
        $0.font = .systemFont(ofSize: 20, weight: .regular)
        $0.numberOfLines = 1
        $0.textColor = .black
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(batteryImageView)
        view.addSubview(backgroundView)
        view.addSubview(nameLabel)

        backgroundView.layer.cornerRadius = 20.0

        batteryImageView.snp.makeConstraints {
            $0.height.width.equalTo(200.0)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50.0)
        }

        backgroundView.snp.makeConstraints {
            $0.top.equalTo(batteryImageView.snp.bottom).offset(95.0)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(430.0)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundView.snp.top).offset(15.0)
            $0.leading.equalToSuperview().offset(20.0)
        }

        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(BatteryCollectionViewCell.height * 5)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5.0)
        }
    }
}

extension BatteryViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BatteryCollectionViewCell.identifier, for: indexPath) as? BatteryCollectionViewCell
        
        cell?.layer.cornerRadius = 20.0
        cell?.backgroundColor = .cellColor
        cell?.layer.shadowOffset = CGSize(width: 10, height: 10)
        cell?.layer.shadowOpacity = 0.1
        
        cell?.layout()
        
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: collectionView.frame.width - 60.0,
            height: BatteryCollectionViewCell.height
        )
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
