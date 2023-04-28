//
//  DemoViewController.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/04/28.
//

import UIKit
import SnapKit

class DemoViewController: UIViewController {
    
    // MARK: - Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "설정"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let itemsTableView: UITableView = {
        let tableView = UITableView()
        // TableView의 델리게이트와 데이터 소스를 설정합니다.
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
        tableView.delegate = self
        tableView.dataSource = self
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        // Title Label을 뷰에 추가합니다.
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.centerX.equalToSuperview()
        }
        
        // TableView를 뷰에 추가합니다.
        view.addSubview(itemsTableView)
        itemsTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource

extension DemoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // 섹션 수를 반환합니다.
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 각 섹션의 항목 수를 반환합니다.
        if section == 0 {
            return 3
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 각 셀을 반환합니다.
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "푸시 알림"
                let switchView = UISwitch()
                switchView.isOn = true // 가정
                switchView.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
                cell.accessoryView = switchView
            case 1:
                cell.textLabel?.text = "사운드"
                cell.accessoryType = .disclosureIndicator
            case 2:
                cell.textLabel?.text = "앱 아이콘 배경색상"
                cell.accessoryType = .disclosureIndicator
            default:
                break
            }
        } else {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "버전"
                cell.detailTextLabel?.text = "1.0.0" // 가정
            case 1:
                cell.textLabel?.text = "계정"
                cell.detailTextLabel?.text = "example@example.com" // 가정
            default:
                break
            }
        }
        
        return cell
    }
    
    // MARK: - Actions
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        // Switch가 변경되었을 때의 액션을 처리합니다.
    }
}

// MARK: - UITableViewDelegate

extension DemoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 각 셀이 선택되었을 때의 액션을 처리합니다.
        if indexPath.section == 0 {
            switch indexPath.row {
            case 1:
                // "사운드" 항목을 선택했을 때의 액션을 처리합니다.
                // 다음 화면으로 이동합니다.
                let soundSettingsVC = SoundSettingsViewController()
                navigationController?.pushViewController(soundSettingsVC, animated: true)
            case 2:
                // "앱 아이콘 배경색상" 항목을 선택했을 때의 액션을 처리합니다.
                // 다음 화면으로 이동합니다.
                let appIconColorSettingsVC = AppIconColorSettingsViewController()
                navigationController?.pushViewController(appIconColorSettingsVC, animated: true)
            default:
                break
            }
        }
    }
}

class SoundSettingsViewController: UIViewController {
    
    // MARK: - Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "사운드"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        // Title Label을 뷰에 추가합니다.
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.centerX.equalToSuperview()
        }
    }
}

class AppIconColorSettingsViewController: UIViewController {
    
    // MARK: - Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "앱 아이콘 배경색상"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        // Title Label을 뷰에 추가합니다.
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.centerX.equalToSuperview()
        }
    }
}
