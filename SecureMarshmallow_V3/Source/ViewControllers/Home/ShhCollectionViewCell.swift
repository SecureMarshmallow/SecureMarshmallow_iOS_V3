import UIKit

class ShhCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ShhCollectionViewCell"
    
    private lazy var sshTitle = UILabel().then {
        $0.text = "SSH 검사"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20.0, weight: .bold)
    }

    private lazy var urlStringTextField = UITextField().then {
        $0.placeholder = "URL을 입력하세요"
        $0.borderStyle = .roundedRect
    }
    
    private lazy var checkSafetyButton = UIButton(type: .system).then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20.0
        
        contentView.addSubview(sshTitle)
        contentView.addSubview(urlStringTextField)
        
        sshTitle.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(20.0)
            $0.leading.trailing.equalTo(contentView).inset(20)
        }
        urlStringTextField.snp.makeConstraints {
            $0.top.equalTo(sshTitle.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(contentView).inset(20)
        }
        
        contentView.addSubview(checkSafetyButton)
        checkSafetyButton.snp.makeConstraints {
            $0.top.equalTo(urlStringTextField.snp.bottom).offset(20)
            $0.centerX.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func checkButtonTapped(_ sender: UIButton) {
        checkURLSafety()
    }

    func checkURLSafety() {
        guard let urlString = urlStringTextField.text, let url = URL(string: urlString) else {
            showAlert(title: "잘못된 URL", message: "올바른 URL을 입력해주세요.")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    if urlString.hasPrefix("https://") {
                        self.showAlert(title: "안전함", message: "이 웹 사이트는 SSL로 암호화되어 안전합니다.")
                    } else {
                        self.showAlert(title: "안전하지 않음", message: "이 웹 사이트는 SSL로 암호화되지 않았으며, 민감한 정보를 사용할 때 불안전할 수 있습니다.")
                    }
                } else {
                    self.showAlert(title: "URL에 액세스할 수 없음", message: "입력한 URL에 대한 액세스가 불가능하거나 해당 웹 사이트가 존재하지 않습니다. 올바른 URL을 입력해주세요.")
                }
            }
        }.resume()
    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(action)

        if let parentVC = self.parentViewController() {
            parentVC.present(alertController, animated: true, completion: nil)
        } else {
            print("Cannot find the view controller.")
        }
    }
}

extension UIView {
    func parentViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self

        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
