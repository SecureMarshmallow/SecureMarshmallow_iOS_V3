import UIKit
import SnapKit
import Then

class LoginViewController: UIViewController {
    
    private let baseURL = "https://2c33-2001-4430-c03f-3e17-b453-85f4-c1a8-643f.ngrok-free.app/"
    
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
                            self.showLoginSuccessAlert(username: username)
                            print("login 성공 \(username)")
                        } else {
                            self.moveLoginButtonToRandomPosition()
                            self.showLoginFailureAlert()
                        }
                    }
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                print("Failed JSON data: \(String(data: data, encoding: .utf8) ?? "")")
            }
        }
        
        task.resume()
    }
    
    private func showLoginSuccessAlert(username: String) {
        let alert = UIAlertController(title: "Login 성공", message: "Welcome, \(username)!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showLoginFailureAlert() {
        let alert = UIAlertController(title: "Login 실패", message: "Invalid username or password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func moveLoginButtonToRandomPosition() {
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
