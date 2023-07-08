import UIKit
import SnapKit
import Then

class LoginViewController: UIViewController {
    
    private let baseURL = "https://2c33-2001-4430-c03f-3e17-b453-85f4-c1a8-643f.ngrok-free.app/"
    
    private var failedLoginAttempts = 0
    
    private lazy var keychainManager = KeychainManager(service: "com.secureMarshmallow-V3")
    
    private let marshmallowImage = UIImageView().then {
        $0.image = UIImage(named: "TransparentLogo")
    }
    
    private let usernameTextField = UITextField().then {
        $0.placeholder = "Username"
        $0.borderStyle = .roundedRect
        $0.backgroundColor = .cellColor
        $0.setPlaceholder(color: .cellTitleColor)
    }
    
    private let passwordTextField = UITextField().then {
        $0.placeholder = "Password"
        $0.borderStyle = .roundedRect
        $0.backgroundColor = .cellColor
        $0.setPlaceholder(color: .cellTitleColor)
        $0.isSecureTextEntry = true
    }
    
    private let loginButton = UIButton().then {
        $0.setTitle("Login", for: .normal)
        $0.backgroundColor = .black
        $0.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
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
        
        view.addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(marshmallowImage.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(40)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(40)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(40)
        }
    }
    
    @objc private func loginButtonTapped() {
            
        guard let username = usernameTextField.text,
              let password = passwordTextField.text else { return }
        
        let parameters = [
            "id": username,
            "password": password
        ]
        
        guard let url = URL(string: baseURL + "api/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = jsonData
        } catch {
            print("Error creating JSON data")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    DispatchQueue.main.async {
                        if let success = json["success"] as? Bool, success {
                            if let token = json["access_token"] as? String {
                                let status = self.keychainManager.storeToken(token, forKey: "access_token")
                                if status == errSecSuccess {
                                    print("Token saved in Keychain")
                                } else {
                                    print("Failed to save token in Keychain, OSStatus: \(status)")
                                }
                                print("Token: \(token)")
                                self.printStoredToken()
                                self.showLoginStatusAlert(title: "Login 성공", message: "Welcome, \(username)!")
                            } else {
                                if let errorDescription = json["error"] as? String {
                                    switch errorDescription {
                                    case "Invalid Request.":
                                        self.showErrorAlert(title: "에러 발생", message: "요청한 데이터가 누락되거나 적정 길이를 초과했습니다.")
                                    case "Invalid request method":
                                        self.showErrorAlert(title: "에러 발생", message: "허용되지 않는 메서드를 사용했습니다.")
                                    default:
                                        self.showLoginStatusAlert(title: "Login 실패", message: "Invalid username or password")
                                    }
                                } else {
                                    self.showLoginStatusAlert(title: "Login 실패", message: "Invalid username or password")
                                }
                                
                                self.failedLoginAttempts += 1
                                
                                if self.failedLoginAttempts == 5 {
                                    self.presentErrorViewController(time: 1)
                                }
                                
                                if self.failedLoginAttempts == 10 {
                                    self.presentErrorViewController(time: 3)
                                }
                                
                                if self.failedLoginAttempts == 15 {
                                    self.presentErrorViewController(time: 5)
                                }
                                self.moveSignupButtonToRandomPosition()
                            }
                        } else {
                            self.failedLoginAttempts += 1
                            
                            if self.failedLoginAttempts == 5 {
                                self.presentErrorViewController(time: 1)
                            }
                            
                            if self.failedLoginAttempts == 10 {
                                self.presentErrorViewController(time: 3)
                            }
                            
                            if self.failedLoginAttempts == 15 {
                                self.presentErrorViewController(time: 5)
                            }
                            
                            self.moveSignupButtonToRandomPosition()
                            self.showErrorAlert(title: "에러 발생", message: "서버 응답을 처리하는 도중 문제가 발생했습니다.")
                        }
                    }
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                print("Failed JSON data: \(String(data: data, encoding: .utf8) ?? "")")
                DispatchQueue.main.async {
                    self.showErrorAlert(title: "에러 발생", message: "서버 응답을 처리하는 도중 문제가 발생했습니다.")
                }
            }
        }
        
        task.resume()
    }

    
    private func presentErrorViewController(time: Int) {
        let errorViewController = ErrorViewController()
        errorViewController.errorTime = time * 60
        errorViewController.modalPresentationStyle = .fullScreen
        self.present(errorViewController, animated: true)
    }
    
    private func printStoredToken() {
        if let accessToken = keychainManager.getToken(forKey: "access_token") {
            print("Stored Token: \(accessToken)")
        } else {
            print("No token found")
        }
    }
    private func showLoginStatusAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            let tapBarViewController = TapBarViewController()
            tapBarViewController.modalPresentationStyle = .fullScreen
            self.present(tapBarViewController, animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    private func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func moveSignupButtonToRandomPosition() {
        let screenWidth = view.bounds.width
        let screenHeight = view.bounds.height
        
        let topSafeAreaHeight = view.safeAreaInsets.top + (self.navigationController?.navigationBar.bounds.height ?? 0)
        let bottomSafeAreaHeight = view.safeAreaInsets.bottom
        let availableHeight = screenHeight - topSafeAreaHeight - bottomSafeAreaHeight
        
        let randomX = CGFloat.random(in: 0...screenWidth - loginButton.bounds.width)
        let randomY = CGFloat.random(in: topSafeAreaHeight...(topSafeAreaHeight + availableHeight - loginButton.bounds.height))
        
        loginButton.snp.remakeConstraints {
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
