import UIKit

// ErrorViewController의 이벤트 함수를 사전에 정의합니다.
protocol ErrorProtocol {
    func setupViews()
    func animationViewEvent()
    func startTimer()
    func customaBackgroundColor()
}

final class ErrorPresenter: NSObject {
    private let viewController: ErrorProtocol
    
    //viewController를 한번 초기화 해줍니다.
    init(viewController:
            ErrorProtocol) {
        self.viewController = viewController
    }
    
    //view의 생명주기에서 메모리가 로드되고 난 후 호출됩니다.
    func viewDidLoad() {
        viewController.animationViewEvent()
    }
    
    //view의 생명주기에서 뷰가 나타나기 직전 호출됩니다.
    func viewDidAppear() {
        viewController.customaBackgroundColor()
        viewController.startTimer()
    }
    
    //view의 layout을 담당합니다.
    func viewDidLayoutSubviews() {
        viewController.setupViews()
    }
}
