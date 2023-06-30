import UIKit
import SnapKit
import Then

class TimerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TimerCollectionViewCell"
    
    var timer: Timer?
    var countdown: Int = 0 {
        didSet {
            updateTimerLabel()
        }
    }
    
    let timeLabel = UILabel().then {
        $0.textAlignment = .center
    }
    
    let startButton = UIButton().then {
        $0.setTitle("시작", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
    }
    
    let stopButton = UIButton().then {
        $0.setTitle("정지", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
    }
    
    let resetButton = UIButton().then {
        $0.setTitle("초기화", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    func setupCell() {
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(15)
        }
        
        addSubview(startButton)
        startButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-10)
        }
        startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        
        addSubview(stopButton)
        stopButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
        }
        stopButton.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
        
        addSubview(resetButton)
        resetButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-10)
        }
        resetButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        
        updateTimerLabel()
    }
    
    func updateTimerLabel() {
        timeLabel.text = "\(countdown) 초"
    }
    
    @objc func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func resetTimer() {
        stopTimer()
        countdown = 0
        updateTimerLabel()
    }
    
    @objc func updateTimer() {
        countdown += 1
        updateTimerLabel()
    }
}
