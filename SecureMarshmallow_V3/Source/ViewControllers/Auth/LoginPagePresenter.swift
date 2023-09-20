import SnapKit
import Then
import UIKit

protocol LoginPageProtocol: AnyObject {
    func setUI()
}

class LoginPagePresenter: NSObject {
    private weak var view: LoginPageProtocol?
    
    init(view: LoginPageProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.setUI()
    }
}
