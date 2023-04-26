//
//  IconViewController.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/04/26.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let whiteButton = UIButton(type: .system)
        whiteButton.setTitle("White Icon", for: .normal)
        whiteButton.addTarget(self, action: #selector(changeToWhiteIcon), for: .touchUpInside)
        view.addSubview(whiteButton)
        
        let oldButton = UIButton(type: .system)
        oldButton.setTitle("Old Icon", for: .normal)
        oldButton.addTarget(self, action: #selector(changeToOldIcon), for: .touchUpInside)
        view.addSubview(oldButton)
        
        let blackButton = UIButton(type: .system)
        blackButton.setTitle("Black Icon", for: .normal)
        blackButton.addTarget(self, action: #selector(changeToBlackIcon), for: .touchUpInside)
        view.addSubview(blackButton)
        
        whiteButton.translatesAutoresizingMaskIntoConstraints = false
        blackButton.translatesAutoresizingMaskIntoConstraints = false
        oldButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            whiteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            whiteButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            oldButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            oldButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            blackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blackButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50)
        ])
    }

    @objc func changeToWhiteIcon() {
        changeAppIcon(to: "WhiteAppIcon")
    }
    
    @objc func changeToBlackIcon() {
        changeAppIcon(to: "BlackAppIcon")
    }
    
    @objc func changeToOldIcon() {
        changeAppIcon(to: "OldAppIcon")
    }

    func changeAppIcon(to iconName: String?) {
        if #available(iOS 10.3, *) {
            if UIApplication.shared.supportsAlternateIcons {
                UIApplication.shared.setAlternateIconName(iconName) { error in
                    if let error = error {
                        print("앱 아이콘을 바꾸는 것을 실패했습니다 ❌ \(error)")
                    } else {
                        print("앱 아이콘이 다음으로 변경됨 \(iconName ?? "BlackIcon")")
                    }
                }
            }
        }
    }
}
