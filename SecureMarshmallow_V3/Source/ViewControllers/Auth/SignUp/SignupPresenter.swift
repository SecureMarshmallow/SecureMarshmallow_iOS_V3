import UIKit
import SnapKit
import Then

protocol SignProtocol: AnyObject {
    func setupUI()
    func showSignupSuccessAlert(userName: String)
    func moveSignupButtonToRandomPosition()
    func showLoginFailureAlert()
}

class SignupPresenter: NSObject {
    private let viewController: SignProtocol
    private let navigationController: UINavigationController
    
    init(viewController: SignProtocol, navigationController: UINavigationController) {
        self.viewController = viewController
        self.navigationController = navigationController
    }
    
    func viewDidLoad() {
        viewController.setupUI()
    }
}
