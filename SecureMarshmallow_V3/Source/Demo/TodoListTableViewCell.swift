//
//  TodoListTableViewCell.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/04/26.
//

import UIKit
import SnapKit

class TodoListTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel!
    var isCompletedSwitch: UISwitch!
    var onSwitchToggle: ((Bool) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupTitleLabel()
        setupIsCompletedSwitch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func setupIsCompletedSwitch() {
        isCompletedSwitch = UISwitch()
        contentView.addSubview(isCompletedSwitch)
        
        isCompletedSwitch.snp.makeConstraints {
            
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
        
        isCompletedSwitch.addTarget(self, action: #selector(onSwitchValueChanged), for: .valueChanged)
    }
    
    @objc func onSwitchValueChanged() {
        onSwitchToggle?(isCompletedSwitch.isOn)
    }
}
