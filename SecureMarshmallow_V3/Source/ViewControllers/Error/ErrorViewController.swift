import UIKit
import RxSwift
import SnapKit
import Then
import Lottie

class ErrorViewController: UIViewController {
    
    //MVP에서 이벤트관련을 방출해줍니다.
    private lazy var presenter = ErrorPresenter(viewController: self)
    
    //비동기 처리를 할 떄 RX를 구현하면서 메모리 낭비를 막아주는 것입니다.
    internal let disposeBag = DisposeBag()
    
    //불이 을렁이는 애니메이션을 주는 것이 animationView 입니다.
    internal var animationView: LottieAnimationView?
    
    var errorTime: Int = 180
    
    var lapCounter: Int = 0
    var mainLapCounter: Int = 0
    
    var lapTimer : Timer?
    var mainLapTimer : Timer?
    
    var userErrorCount = 0
    
    //errorTimer를 선언하는데 errorTimer는 말그대로 Timer Label을 말합니다.
    internal let errorTimer = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 40, weight: .bold)
    }
    
    //waitLabel은 몇회 경고를 받았는지 보여주는 label입니다.
    internal lazy var waitLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20, weight: .regular)
        $0.text = "누군가 회원님의 계정을 \(errorTimerText(errorTime))회 입력했습니다\n 조금만 기다려주세요)"
        $0.numberOfLines = 0
    }
    
    //view의 생명 주기에서 view의 layout을 담당합니다.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        presenter.viewDidLayoutSubviews()
    }
    
    //view에 생명주기에서 view가 나타나기 직전 호출됩니다.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.viewDidAppear()
    }
    
    //view의 생명주기에서 view가 메로리에 로드된 후 호출됩니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension ErrorViewController: ErrorProtocol {
    
    //setupViews는 layout을 처리하는데 사용합니다.
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
    
    //타이머의 시작을 담당합니다.
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
        //타이머가 시작되면 애니메이션이 실행됩니다.
        animationView!.play()
    }
    
    //애니메이션의 속도, 시간, 위치 등등을 선언합니다.
    func animationViewEvent() {
        animationView = .init(name: "fire")
        
        animationView!.loopMode = .loop
        
        animationView!.animationSpeed = 0.1
        
        animationView!.center = view.center
        
        animationView!.contentMode = .scaleAspectFill
    }
    
    //customaBackgroundColor는 바탕화면의 색을 선언합니다.
    func customaBackgroundColor() {
        self.view.backgroundColor = .errorColor
    }
}

//연산관련 함수들
extension ErrorViewController {
    
    func errorTimerText(_ errorCountText: Int) -> Int {
        userErrorCount = errorCountText / 60
        return userErrorCount
    }
    
    //라벨의 초를 움직입니다.
    func updateLabel( label : UILabel, counter : Int, time: Int){
        let threeMinutes: Int = time
        errorTimer.text = secondsToHourMinuteSecond(seconds: Int(threeMinutes - counter))
    }
    
    func secondsToHourMinuteSecond( seconds : Int )->String{
        let minute = seconds / 60 % 60
        let second = seconds % 60
        
        // 둘다 0이면 끝났으니 화면 전환 코드를 수행합니다.
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
