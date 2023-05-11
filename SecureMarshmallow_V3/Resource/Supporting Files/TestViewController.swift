//
//  TestViewController.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/10.
//

import UIKit
import SnapKit
import Then

class TestViewController: UIViewController {
    
    private let customButton = ShadowButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let shadowButton = ShadowButton(frame: CGRect(x: 50, y: 50, width: 150, height: 50))
        shadowButton.addTarget(self, action: #selector(shadowButtonTapped), for: .valueChanged)
        view.addSubview(shadowButton)

    }

    @objc func shadowButtonTapped(sender: ShadowButton) {
        if sender.isSelected {
            print("Button is selected")
        } else {
            print("Button is deselected")
        }
    }
}
