//
//  BatteryViewController.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/11.
//

import UIKit
import SnapKit
import Then

class BatteryViewController: UIViewController {
    
    private lazy var batteryImageView = UIImageView().then {
        $0.image = UIImage(named: "Battery")
    }
    
    private lazy var backgroundView = UIView().then {
        $0.backgroundColor = .BackGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(batteryImageView)
        view.addSubview(backgroundView)
        
        backgroundView.layer.cornerRadius = 20.0
        
        batteryImageView.snp.makeConstraints {
            $0.height.width.equalTo(200.0)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80.0)
        }
        
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(batteryImageView.snp.bottom).offset(95.0)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(430.0)
        }
    }
    
}
