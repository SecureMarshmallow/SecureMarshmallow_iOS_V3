import UIKit
import SnapKit

class OSViewController: BaseEP {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWith(self)
        collectionView.dataSource = self
    }
    
    override func updateWith(_ controller: UIViewController) {
        super.updateWith(controller)
        
        nameLabel.text = "iOS"
        customImageView.image = UIImage(named: "iPhone")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
