import UIKit
import SnapKit
import Then

class LoginPageViewController: UIViewController {
    
    let marshmallowImages = UIImageView().then {
        $0.image = UIImage(named: "TransparentLogo")
    }
    
    let loginButton = UIButton(type: .system).then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .black
        $0.addTarget(LoginPageViewController.self, action: #selector(loginTapped), for: .touchUpInside)
        $0.layer.cornerRadius = 10.0
    }
    
    let signUpButton = UIButton(type: .system).then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .black
        $0.addTarget(LoginPageViewController.self, action: #selector(signUpTapped), for: .touchUpInside)
        $0.layer.cornerRadius = 10.0
    }
    
    let resetButton = UIButton(type: .system).then {
        $0.setTitle("비밀번호 초기화", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = .black
        $0.addTarget(LoginPageViewController.self, action: #selector(resetTapped), for: .touchUpInside)
        $0.layer.cornerRadius = 10.0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        [
            marshmallowImages,
            loginButton,
            signUpButton,
            resetButton
        ].forEach { view.addSubview($0) }
                
        marshmallowImages.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-100)
            $0.width.equalTo(250)
            $0.height.equalTo(250)
        }
                
        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(marshmallowImages.snp.bottom).offset(80)
            $0.width.equalTo(370)
            $0.height.equalTo(54)
        }
                
        signUpButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.width.equalTo(370)
            $0.height.equalTo(54)
        }
                
        resetButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(signUpButton.snp.bottom).offset(20)
            $0.width.equalTo(370)
            $0.height.equalTo(54)
        }
    }
    
    @objc func loginTapped() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc func signUpTapped() {
        self.navigationController?.pushViewController(SignupViewController(), animated: true)
    }
    
    @objc func resetTapped() {
        // 비밀번호 초기화 버튼을 눌렀을 때 실행되는 함수를 여기에 구현합니다.
    }
}
