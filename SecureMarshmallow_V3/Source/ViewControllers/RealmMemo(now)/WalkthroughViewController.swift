//
//  WalkthroughViewController.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/06/08.
//

import UIKit
import SnapKit
import Then

class WalkthroughViewController: UIViewController {
    
    // MARK: - Properties
    let popupView = UIView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 12
    }
    
    let welcomeLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .boldSystemFont(ofSize: 22)
        $0.numberOfLines = 0
        $0.text = "처음 오셨군요!\n환영합니다 😄\n\n당신만의 메모를 작성하고\n관리해보세요."
    }
    
    let okButton = UIButton().then {
        $0.backgroundColor = .systemOrange
        $0.layer.cornerRadius = 8
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.textColor = .label
        $0.titleLabel?.font = .boldSystemFont(ofSize: 20)
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setConstraints()
    }
    
    // MARK: - Helpers
    func setupUI() {
        view.backgroundColor = .secondaryLabel /// 배경 반투명하게
        
        self.view.addSubview(popupView)
        popupView.addSubview(okButton)
        popupView.addSubview(welcomeLabel)
        
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        
        
    }
    
    func setConstraints() {
        popupView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(250)
            make.centerX.centerY.equalToSuperview()
        }
        
        okButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(okButton.snp.top).offset(-20)
            
        }
        
    }
    
    // MARK: - Actions
    @objc func okButtonTapped() {
        self.dismiss(animated: true)
    }

}
