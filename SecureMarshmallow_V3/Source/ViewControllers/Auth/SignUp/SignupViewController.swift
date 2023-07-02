import UIKit
import SnapKit
import Then

class SignupViewController: UIViewController {
    
    private let marshmallowImage = UIImageView().then {
        $0.image = UIImage(named: "TransparentLogo")
    }
    
    private let idTextField = UITextField().then {
        $0.placeholder = "Id"
        $0.borderStyle = .roundedRect
        $0.backgroundColor = .cellColor
        $0.setPlaceholder(color: .cellTitleColor)
    }
    
    private let emailTextField = UITextField().then {
        $0.placeholder = "Email"
        $0.borderStyle = .roundedRect
        $0.backgroundColor = .cellColor
        $0.setPlaceholder(color: .cellTitleColor)
    }
    
    private let nicknameTextField = UITextField().then {
        $0.placeholder = "Nickname"
        $0.borderStyle = .roundedRect
        $0.backgroundColor = .cellColor
        $0.setPlaceholder(color: .cellTitleColor)
        $0.isSecureTextEntry = true
    }
    
    private let passwordTextField = UITextField().then {
        $0.placeholder = "Password"
        $0.borderStyle = .roundedRect
        $0.backgroundColor = .cellColor
        $0.setPlaceholder(color: .cellTitleColor)
        $0.isSecureTextEntry = true
    }
    
    private let signupButton = UIButton().then {
        $0.setTitle("Signup", for: .normal)
        $0.backgroundColor = .black
        $0.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        $0.layer.cornerRadius = 10.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(marshmallowImage)
        marshmallowImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80.0)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(200.0)
        }
        
        view.addSubview(idTextField)
        idTextField.snp.makeConstraints {
            $0.top.equalTo(marshmallowImage.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(40)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(40)
        }
        
        view.addSubview(nicknameTextField)
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(40)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(40)
        }
        
        view.addSubview(signupButton)
        signupButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(40)
        }
    }
    
    @objc private func signupButtonTapped() {
        let enteredUsername = idTextField.text ?? ""
        let enteredPassword = passwordTextField.text ?? ""
        
        if enteredPassword == "password" {
            showSignupSuccessAlert(username: enteredUsername)
        } else {
            moveSignupButtonToRandomPosition()
            showLoginFailureAlert()
        }
    }
    
    private func showSignupSuccessAlert(username: String) {
        let alert = UIAlertController(title: "Login 성공", message: "Welcome, \(username)!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showLoginFailureAlert() {
        let alert = UIAlertController(title: "Login 실패", message: "Invalid username or password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func moveSignupButtonToRandomPosition() {
        let screenWidth = view.bounds.width
        let screenHeight = view.bounds.height
        
        let topSafeAreaHeight = view.safeAreaInsets.top + (self.navigationController?.navigationBar.bounds.height ?? 0)
        let bottomSafeAreaHeight = view.safeAreaInsets.bottom
        let availableHeight = screenHeight - topSafeAreaHeight - bottomSafeAreaHeight
        
        let randomX = CGFloat.random(in: 0...screenWidth - signupButton.bounds.width)
        let randomY = CGFloat.random(in: topSafeAreaHeight...(topSafeAreaHeight + availableHeight - signupButton.bounds.height))
        
        signupButton.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(randomY)
            $0.leading.equalToSuperview().offset(randomX)
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
