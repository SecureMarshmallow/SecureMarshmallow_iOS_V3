import UIKit
import SnapKit
import Then
import Lottie

class ErrorViewController: UIViewController {
    
    private lazy var presenter = ErrorPresenter(viewController: self)
        
    internal var animationView: LottieAnimationView?
    
    var errorTime: Int = 180
    
    var lapCounter: Int = 0
    var mainLapCounter: Int = 0
    
    var lapTimer : Timer?
    var mainLapTimer : Timer?
    
    var userErrorCount = 0
    
    internal let errorTimer = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 40, weight: .bold)
    }
    
    internal lazy var waitLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20, weight: .regular)
        $0.text = "누군가 회원님의 계정을 \(errorTimerText(errorTime))회 입력했습니다\n 조금만 기다려주세요)"
        $0.numberOfLines = 0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        presenter.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.viewDidAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension ErrorViewController: ErrorProtocol {
    
    func setupViews() {
        self.view.addSubview(animationView!)
        [errorTimer,waitLabel].forEach { self.view.addSubview($0) }
        
        self.animationView!.snp.makeConstraints {
            $0.top.equalToSuperview().offset(180.0)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(155)
        }
        
        self.errorTimer.snp.makeConstraints {
            $0.top.equalTo(animationView!.snp.bottom).offset(30.0)
            $0.centerX.equalToSuperview()
        }
        
        self.waitLabel.snp.makeConstraints {
            $0.top.equalTo(errorTimer.snp.bottom).offset(160.0)
            $0.centerX.equalToSuperview()
        }
    }
    
    func startTimer(){
        self.errorTimer.text = "00:00"
        
        if mainLapTimer == nil{
            mainLapTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(mainLapTimerUpdate), userInfo: nil, repeats: true)
            RunLoop.current.add(mainLapTimer!, forMode: .common)
        }
        if lapTimer == nil{
            lapTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(lapTimerUpdate), userInfo: nil, repeats: true)
            RunLoop.current.add(lapTimer!, forMode: .common)
        }
        animationView!.play()
    }
    
    func animationViewEvent() {
        animationView = .init(name: "fire")
        
        animationView!.loopMode = .loop
        
        animationView!.animationSpeed = 0.1
        
        animationView!.center = view.center
        
        animationView!.contentMode = .scaleAspectFill
    }
    
    func customaBackgroundColor() {
        self.view.backgroundColor = .errorColor
    }
}

extension ErrorViewController {
    
    func errorTimerText(_ errorCountText: Int) -> Int {
        userErrorCount = errorCountText / 60
        return userErrorCount
    }
    
    func updateLabel( label : UILabel, counter : Int, time: Int){
        let threeMinutes: Int = time
        errorTimer.text = secondsToHourMinuteSecond(seconds: Int(threeMinutes - counter))
    }
    
    func secondsToHourMinuteSecond( seconds : Int )->String{
        let minute = seconds / 60 % 60
        let second = seconds % 60
        
        if minute == 0 && second == 0 {
            lapTimer?.invalidate()
            mainLapTimer?.invalidate()
            
            DispatchQueue.main.async {
                self.presentLoginViewController()
            }
        }
        
        return String(format: "%02i:%02i", minute, second )
    }
    
    private func presentLoginViewController() {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        self.present(loginViewController, animated: true)
    }
    
    @objc func mainLapTimerUpdate(){
        mainLapCounter += 1
        updateLabel(label: errorTimer, counter: mainLapCounter, time: errorTime)
    }
    
    @objc func lapTimerUpdate(){
        lapCounter += 1
    }
    
}
