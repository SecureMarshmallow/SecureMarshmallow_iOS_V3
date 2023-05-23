import UIKit
import SnapKit
import Then

protocol BatteryProtocol: AnyObject {
    func batteryState()
    func batteryNotification()
    func navigationSetup()
}

class BatteryPresenter: NSObject {
    private let viewController: BatteryProtocol
    private let navigationController: UINavigationController
    
    init(viewController: BatteryProtocol, navigationController: UINavigationController) {
        self.viewController = viewController
        self.navigationController = navigationController
    }
    
    func updateWiths() {
        viewController.batteryState()
        viewController.batteryNotification()
        viewController.navigationSetup()
    }
}

extension BatteryPresenter: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExplanationCollectionViewCell.identifier, for: indexPath) as? ExplanationCollectionViewCell
        
        cell?.layer.cornerRadius = 20.0
        cell?.backgroundColor = .cellColor
        cell?.layer.shadowOffset = CGSize(width: 10, height: 10)
        cell?.layer.shadowOpacity = 0.1
        
        if indexPath.row == 0 {
            cell?.titleLabel.text = "저전력 모드"
            let isLowPowerMode = ProcessInfo.processInfo.isLowPowerModeEnabled
            cell?.descriptionLabel.text = "\(isLowPowerMode)"
        }
        if indexPath.row == 1 {
            cell?.titleLabel.text = "OS 이름"
            let batteryLevel = UIDevice.current.batteryLevel
            let batteryLevelPercentage = Int(batteryLevel * 100)
            cell?.descriptionLabel.text = "\(abs(batteryLevelPercentage))%"
        }
        if indexPath.row == 2 {
            cell?.titleLabel.text = "근접 모니터링"
            let isMonitoring = UIDevice.current.isProximityMonitoringEnabled
            cell?.descriptionLabel.text = "\(isMonitoring)"
        }
        if indexPath.row == 3 {
            cell?.titleLabel.text = "배터리 상태"
            
            let batteryState = UIDevice.current.batteryState
            
            var nowBatteryState: String = ""
            
            switch batteryState {
            case .unknown:
                nowBatteryState = "unknown"
            case .unplugged:
                nowBatteryState = "unplugged"
            case .charging:
                nowBatteryState = "charging"
            case .full:
                nowBatteryState = "full"

            @unknown default:
                fatalError()
            }
            
            cell?.descriptionLabel.text = "\(nowBatteryState)"
        }
        
        cell?.layout()
        
        return cell ?? UICollectionViewCell()
    }
}
