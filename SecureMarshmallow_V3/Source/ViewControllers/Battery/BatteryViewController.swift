import UIKit
import SnapKit
import Then

class BatteryViewController: BaseEP {
    
    private lazy var presenter = BatteryPresenter(viewController: self, navigationController: navigationController!)
    
    let battery = UIDevice.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWith(self)
        collectionView.dataSource = presenter
    }
    
    override func updateWith(_ controller: UIViewController) {
        super.updateWith(controller)
        
        customImageView.image = UIImage(named: "battery")
        
        presenter.updateWiths()
        
    }
}
extension BatteryViewController: BatteryProtocol {
    
    func batteryState() {
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
    }
    
    func batteryNotification() {
        // 배터리 관련 알림 받기
        NotificationCenter.default.addObserver(forName: UIDevice.batteryLevelDidChangeNotification, object: battery, queue: nil) { (notification) in
            let batteryLevel = UIDevice.current.batteryLevel
            print("배터리 레벨이 변경됨: \(batteryLevel)")
        }
    }
    
    func navigationSetup() {
        nameLabel.text = "iOS"
    }
    
}
