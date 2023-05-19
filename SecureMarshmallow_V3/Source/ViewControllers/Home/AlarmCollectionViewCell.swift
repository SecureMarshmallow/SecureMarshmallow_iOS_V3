//
//  AlarmCollectionViewCell.swift
//  Pods
//
//  Created by 박준하 on 2023/05/17.
//

import UIKit
import Then
import SnapKit

class AlarmCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AlarmCollectionViewCell"
    
    var timeLabel = UILabel().then {
        $0.text = "00:00"
        $0.textColor = .cellTitleColor
        $0.numberOfLines = 1
        $0.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
    var dateLabel = UILabel().then {
        $0.text = "Mon, 14 Dec"
        $0.textColor = .cellTitleColor
        $0.numberOfLines = 1
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
    }
    
    var switchView: UISwitch = {
        let switchDemo = UISwitch()
        switchDemo.translatesAutoresizingMaskIntoConstraints = false
        switchDemo.tintColor = .gray
        switchDemo.onTintColor = .black
        switchDemo.thumbTintColor = .white
        switchDemo.setOn(false, animated: true)
        return switchDemo
    }()
    
    func layout() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(switchView)
        
        timeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(30.0)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(12.0)
//            $0.leading.equalToSuperview().offset(15.0)
            $0.centerX.equalTo(timeLabel.snp.centerX)
        }
        
        switchView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(40.0)
//            $0.leading.equalTo(dateLabel.snp.trailing).offset(10)
//            $0.trailing.equalToSuperview().inset(5.0)
            $0.centerX.equalTo(dateLabel.snp.centerX)
        }
    }
}
