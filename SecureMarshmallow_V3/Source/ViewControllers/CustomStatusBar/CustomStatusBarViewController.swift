import UIKit
import SnapKit

class CustomStatusBarViewController: UIViewController {
    private let statusBarView = UIView()
    private let signalImageView = UIImageView()
    private let batteryImageView = UIImageView()
    private let clockLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureStatusBarView()
        configureSignalImageView()
        configureBatteryImageView()
        configureClockLabel()
        updateTime()
        
        view.backgroundColor = .white
        // Update time label every second
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateTime()
        }
    }

    private func configureStatusBarView() {
        statusBarView.backgroundColor = .black
        view.addSubview(statusBarView)
        statusBarView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(44)
        }
    }

    private func configureSignalImageView() {
        signalImageView.image = UIImage(systemName: "wifi")
        signalImageView.tintColor = .white
        statusBarView.addSubview(signalImageView)
//        signalImageView.snp.makeConstraints { make in
//            make.leading.equalTo(statusBarView).offset(16)
//            make.centerY.equalTo(statusBarView)
//        }
        statusBarView.snp.makeConstraints {
            $0.centerY.equalTo(batteryImageView.snp.centerX)
            $0.trailing.
        }
    }

    private func configureBatteryImageView() {
        batteryImageView.image = UIImage(systemName: "battery.100")
        batteryImageView.tintColor = .white
        statusBarView.addSubview(batteryImageView)
        batteryImageView.snp.makeConstraints { make in
            make.trailing.equalTo(statusBarView).offset(-16)
            make.centerY.equalTo(statusBarView)
        }
    }

    private func configureClockLabel() {
        clockLabel.textColor = .white
        clockLabel.font = UIFont.systemFont(ofSize: 14)
        statusBarView.addSubview(clockLabel)
        clockLabel.snp.makeConstraints { make in
            make.centerX.equalTo(statusBarView)
            make.centerY.equalTo(statusBarView)
        }
    }

    private func updateTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let currentTime = dateFormatter.string(from: Date())
        clockLabel.text = currentTime
    }
}
