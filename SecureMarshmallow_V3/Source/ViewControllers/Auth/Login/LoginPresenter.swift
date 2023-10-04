import SnapKit
import Then
import UIKit

protocol LoginProtocol: AnyObject {
    func setUI()
    func presentErrorViewController(time: Int)
    func showLoginStatusAlert(title: String, message: String)
    func showErrorAlert(title: String, message: String)
    func moveSignupButtonToRandomPosition()
}

class LoginPresenter: NSObject {
    private weak var view: LoginProtocol?
    
    init(view: LoginProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.setUI()
    }
    
    func loginButtonTapped(username: String, password: String) {
        NetworkManager.shared.login(username: username, password: password) { [weak self] result in
            switch result {
            case .success(let token):
                self?.view?.showLoginStatusAlert(title: "Login 성공", message: "Welcome, \(username)!")
                
            case .failure(let error):
                switch error {
                case NetworkError.noData:
                    self?.view?.showErrorAlert(title: "에러 발생", message: "데이터 없음")
                case NetworkError.invalidResponse:
                    self?.view?.showErrorAlert(title: "에러 발생", message: "유효하지 않은 응답")
                case NetworkError.authenticationFailed:
                    self?.view?.showLoginStatusAlert(title: "Login 실패", message: "인증 실패")
                default:
                    self?.view?.showErrorAlert(title: "에러 발생", message: "네트워크 에러")
                }
            }
        }
    }
}
