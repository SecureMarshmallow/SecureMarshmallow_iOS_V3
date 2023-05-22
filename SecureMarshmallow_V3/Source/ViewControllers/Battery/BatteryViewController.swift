import UIKit
import SnapKit
import Then

class BatteryViewController: BaseEP {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWith(self)
        collectionView.dataSource = self
        
        let battery = UIDevice.current
        
        NotificationCenter.default.addObserver(forName: UIDevice.batteryStateDidChangeNotification, object: battery, queue: nil) { (notification) in
            let batteryState = UIDevice.current.batteryState
            switch batteryState {
            case .unknown:
                print("배터리 상태가 변경됨: unknown")
            case .unplugged:
                print("배터리 상태가 변경됨: unplugged")
            case .charging:
                print("배터리 상태가 변경됨: charging")
            case .full:
                print("배터리 상태가 변경됨: full")
            @unknown default:
                fatalError()
            }
        }
        
        // 배터리 관련 알림 받기
        NotificationCenter.default.addObserver(forName: UIDevice.batteryLevelDidChangeNotification, object: battery, queue: nil) { (notification) in
            let batteryLevel = UIDevice.current.batteryLevel
            print("배터리 레벨이 변경됨: \(batteryLevel)")
        }
    }
    
    override func updateWith(_ controller: UIViewController) {
        super.updateWith(controller)
        
        nameLabel.text = "iOS"
        customImageView.image = UIImage(named: "Battery")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
