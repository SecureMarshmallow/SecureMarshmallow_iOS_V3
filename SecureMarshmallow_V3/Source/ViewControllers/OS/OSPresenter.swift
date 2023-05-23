//
//  OSPresenter.swift
//  
//
//  Created by 박준하 on 2023/05/23.
//

import UIKit
import SnapKit
import Then

protocol OSProtocol: AnyObject {
    func navigationSetup()
}

class OSPresenter: NSObject {
    private let viewController: OSProtocol
    private let navigationController: UINavigationController
    
    init(viewController: OSProtocol, navigationController: UINavigationController) {
        self.viewController = viewController
        self.navigationController = navigationController
    }
    
    func updateWiths() {
        viewController.navigationSetup()
    }
}

extension OSPresenter: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let device = UIDevice.current
        
        let deviceName = device.name
        let systemName = device.systemName
        let systemVersion = device.systemVersion
        let model = device.model
        let localizedModel = device.localizedModel
        let uuid = device.identifierForVendor?.uuidString ?? "Unknown"
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExplanationCollectionViewCell.identifier, for: indexPath) as? ExplanationCollectionViewCell
        
        cell?.layer.cornerRadius = 20.0
        cell?.backgroundColor = .cellColor
        cell?.layer.shadowOffset = CGSize(width: 10, height: 10)
        cell?.layer.shadowOpacity = 0.1
        
        if indexPath.row == 0 {
            cell?.titleLabel.text = "디바이스 이름"
            cell?.descriptionLabel.text = "\(deviceName)"
        }
        if indexPath.row == 1 {
            cell?.titleLabel.text = "OS 이름"
            cell?.descriptionLabel.text = "\(systemName)"
        }
        if indexPath.row == 2 {
            cell?.titleLabel.text = "버전"
            cell?.descriptionLabel.text = "\(systemVersion)"
        }
        if indexPath.row == 3 {
            cell?.titleLabel.text = "모델"
            cell?.descriptionLabel.text = "\(model)"
        }
        if indexPath.row == 4 {
            cell?.titleLabel.text = "언어"
            cell?.descriptionLabel.text = "\(localizedModel)"
        }
        if indexPath.row == 5 {
            cell?.titleLabel.text = "UUID"
//            cell?.descriptionLabel.text = "\(uuid)"
        }
        
        
        cell?.layout()
        
        return cell ?? UICollectionViewCell()
    }
}
