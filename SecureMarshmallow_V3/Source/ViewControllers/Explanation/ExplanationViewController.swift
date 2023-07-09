//
//  ExplanationViewController.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/07/09.
//

import UIKit
import SnapKit

// ViewController (View)
class ExplanationViewController: UIViewController {
    
    private var tableView = UITableView(frame: .zero, style: .grouped)
    private let sectionHeader = ["앱 보안", "웹 보안"]
    private let cellDataSource = [["SHH란?", "HMAC", "탈옥", "앱 열기 추적", "스크린샷 추적", "키체인이란?", "스크린샷 방지" ], ["정보", "어쩌고저쩌고"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupTableView()
    }
    
    func setupNavigationItem() {
        title = "설정"
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .white
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationController?.navigationBar.barTintColor = .white
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingCell")
        view.addSubview(tableView)
        
        setupConstraints()
        
        tableView.backgroundColor = .white
        
        tableView.rowHeight = 60.0
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ExplanationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeader.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        let label = UILabel()
        label.text = sectionHeader[section]
        label.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        label.textColor = .black
        
        headerView.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath)
        
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = cellDataSource[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                self.navigationController?.pushViewController(DetailExplanationViewController(mainTitleText: "SHH란?", explanationTitleText: "사용 이유", nameDetailTitleText: "- SSH란 Secure Shell Protocol의 약자로 네트워크 프로토콜 중 하나입니다.\n\n- Public Network를 통해 서로 통신을 할 때 보안적으로 안전하게 통신을 하기 위해 사용하는 프로토콜입니다.", explanationDetailTitleText: "SSH 검사를 통해 보안이 안전한 URL을 사용함으로써 개인정보를 지킬 수 있습니다.", imageView: UIImage(named: "WhiteAppIcon")!), animated: true)
            case 1:
                self.navigationController?.pushViewController(DetailExplanationViewController(mainTitleText: "HMAC란?", explanationTitleText: "메소드 확인 방법", nameDetailTitleText: "- Hash based Message Authentication의 약자로 MAC 기술의 일종으로, 원본 메시지가 변하면 그 해시값도 변하는 해싱(Hashing)의 특징을 활용하여 메시지의 변조 여부를 확인(인증) 하여 무결성과 기밀성을 제공하는 기술\n\n- HMAC이란 메시지 인증을 위한 Keyed-Hashing입니다.", explanationDetailTitleText: """
메서드 내부에서는 메세지가 변조됐는지 나타내는 불리언 값에 따라 검증할 메시지를 설정합니다. 불리언 값이 `true`인 경우, "This is a tampered message."라는 변조된 메시지로 설정됩니다. `false`인 경우, "This is the original message."라는 원본 메시지로 설정됩니다.

검증은 HMAC을 사용하여 수행됩니다. 변조된 메시지인 경우, 새로운 HMAC 코드를 생성하고 해당 HMAC 코드와 원본 메시지를 사용하여 유효성을 검사합니다. 변조되지 않은 메시지인 경우, 주어진 HMAC 코드와 메시지를 사용하여 유효성을 검사합니다.

검증 결과에 따라 결과 레이블에 "변조되지 않았습니다." 또는 "변조 되었습니다."와 같은 적절한 텍스트가 표시됩니다.
""", imageView: UIImage(named: "WhiteAppIcon")!), animated: true)
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                print("1,1")
            case 1:
                print("1.2")
            default:
                break
            }
        default:
            break
        }
    }
}
