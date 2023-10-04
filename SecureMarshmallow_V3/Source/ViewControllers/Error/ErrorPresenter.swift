import UIKit

protocol ErrorProtocol {
    func setupViews()
    func animationViewEvent()
    func startTimer()
    func customaBackgroundColor()
}

final class ErrorPresenter: NSObject {
    private let viewController: ErrorProtocol
    
    init(viewController:
            ErrorProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.animationViewEvent()
    }
    
    func viewDidAppear() {
        viewController.customaBackgroundColor()
        viewController.startTimer()
    }
    
    func viewDidLayoutSubviews() {
        viewController.setupViews()
    }
}
