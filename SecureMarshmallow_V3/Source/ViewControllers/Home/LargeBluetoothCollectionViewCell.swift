import UIKit
import CoreBluetooth
import SnapKit
import Then

protocol BluetoothStatusProvider {
    func getBluetoothState() -> CBManagerState
    func isConnectedToPeripheral() -> Bool
}

class LargeBluetoothCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "LargeBluetoothCollectionViewCell"
    
    private var statusProvider: BluetoothStatusProvider?
    
    private var nameLabel: UILabel!
    private var statusLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        nameLabel = UILabel().then {
            $0.textAlignment = .center
            $0.font = UIFont.boldSystemFont(ofSize: 24)
        }
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }

        statusLabel = UILabel().then {
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 18)
        }
        contentView.addSubview(statusLabel)
        
        statusLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
    }
    
    func configure(with name: String, statusProvider: BluetoothStatusProvider) {
        self.statusProvider = statusProvider
        nameLabel.text = name
        displayBluetoothStatus()
    }

    private func displayBluetoothStatus() {
        guard let statusProvider = statusProvider else { return }

        let bluetoothState = statusProvider.getBluetoothState()
        let isConnected = statusProvider.isConnectedToPeripheral()

        if isConnected {
            statusLabel.text = "Connected"
        } else {
            switch bluetoothState {
            case .poweredOn:
                statusLabel.text = "Powered On"
            case .poweredOff:
                statusLabel.text = "Powered Off"
            case .unsupported:
                statusLabel.text = "Unsupported"
            case .unauthorized:
                statusLabel.text = "Unauthorized"
            case .resetting:
                statusLabel.text = "Resetting"
            case .unknown:
                statusLabel.text = "Unknown"
            @unknown default:
                statusLabel.text = "Unknown"
            }
        }
    }
}
