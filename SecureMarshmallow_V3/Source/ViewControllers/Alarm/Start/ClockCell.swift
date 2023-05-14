//
//  ClockCell.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/14.
//

import UIKit
import Then
import SnapKit

class ClockCell: UICollectionViewCell {
    
    private let nameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .lightGray
        $0.numberOfLines = 0
    }
    
    private let chevronImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        $0.isHidden = false
    }
    
    private let switchView = UISwitch().then {
        $0.setOn(false, animated: true)
    }
    
    var switchValueChanged: ((Bool) -> ()) = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        switchView.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        
        layer.cornerRadius = 10
        backgroundColor = .black
        layer.borderWidth = 1
        
        addSubviews([
            nameLabel,
            chevronImageView,
            switchView
        ])
        
        layout()
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.rightAnchor.constraint(equalTo: switchView.leftAnchor),

            chevronImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            chevronImageView.widthAnchor.constraint(equalToConstant: 10),
            chevronImageView.heightAnchor.constraint(equalToConstant: 20),
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),

            switchView.centerYAnchor.constraint(equalTo: centerYAnchor),
            switchView.rightAnchor.constraint(equalTo: chevronImageView.leftAnchor, constant: -16),
        ])
    }

    func configureWith(_ clock: Clock, capableOfHidden: Bool = false, chevronHidden: Bool = false) {
        nameLabel.text = clock.name
        switchView.isOn = clock.isActivated
        chevronImageView.isHidden = chevronHidden
        if (switchView.isOn) {
            layer.borderColor = UIColor.white.cgColor
            nameLabel.textColor = .white
        }
        else {
            layer.borderColor = UIColor.darkGray.cgColor
            nameLabel.textColor = .lightGray
        }
    }
    
    @objc func switchStateDidChange(_ sender:UISwitch!)
    {
        let defaults = UserDefaults.standard
        let key = nameLabel.text
        if (sender.isOn == true){
            print("UISwitch state is now ON")
            defaults.set(true, forKey: key!)
            print(key!)
            nameLabel.textColor = .white
            layer.borderColor = UIColor.white.cgColor
        }
        else{
            print("UISwitch state is now Off")
            defaults.set(false, forKey: key!)
            print(key!)
            nameLabel.textColor = .lightGray
            layer.borderColor = UIColor.darkGray.cgColor
        }
        switchValueChanged(sender.isOn)
    }
}
