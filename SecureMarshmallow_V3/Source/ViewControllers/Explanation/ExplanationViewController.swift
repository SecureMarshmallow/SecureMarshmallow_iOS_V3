import UIKit
import SnapKit

// ViewController (View)
class ExplanationViewController: UIViewController {
    
    private var tableView = UITableView(frame: .zero, style: .grouped)
    private let sectionHeader = ["앱 보안", "웹 보안"]
    private let cellDataSource = [["SHH란?", "HMAC", "탈옥", "앱 열기 추적", "스크린샷 추적", "키체인이란?", "스크린샷 방지" ], ["웹 보안 정책이란?", "해외 아이피 차단 방화벽?"]]
    
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
                self.navigationController?.pushViewController(DetailExplanationViewController(mainTitleText: "SHH란?", explanationTitleText: "사용 이유", nameDetailTitleText: "- Secure Shell Protocol의 약자로 네트워크 프로토콜 중 하나입니다.\n\n- Public Network를 통해 서로 통신을 할 때 보안적으로 안전하게 통신을 하기 위해 사용하는 프로토콜입니다.", explanationDetailTitleText: "SSH 검사를 통해 보안이 안전한 URL을 사용함으로써 개인정보를 지킬 수 있습니다.", imageView: UIImage(named: "WhiteAppIcon")!), animated: true)
            case 1:
                self.navigationController?.pushViewController(DetailExplanationViewController(mainTitleText: "HMAC란?", explanationTitleText: "메소드 확인 방법", nameDetailTitleText: "- Hash based Message Authentication의 약자로 MAC 기술의 일종으로, 원본 메시지가 변하면 그 해시값도 변하는 해싱(Hashing)의 특징을 활용하여 메시지의 변조 여부를 확인(인증) 하여 무결성과 기밀성을 제공하는 기술\n\n- HMAC이란 메시지 인증을 위한 Keyed-Hashing입니다.", explanationDetailTitleText: """
메서드 내부에서는 메세지가 변조됐는지 나타내는 불리언 값에 따라 검증할 메시지를 설정합니다. 불리언 값이 `true`인 경우, "This is a tampered message."라는 변조된 메시지로 설정됩니다. `false`인 경우, "This is the original message."라는 원본 메시지로 설정됩니다.

검증은 HMAC을 사용하여 수행됩니다. 변조된 메시지인 경우, 새로운 HMAC 코드를 생성하고 해당 HMAC 코드와 원본 메시지를 사용하여 유효성을 검사합니다. 변조되지 않은 메시지인 경우, 주어진 HMAC 코드와 메시지를 사용하여 유효성을 검사합니다.

검증 결과에 따라 결과 레이블에 "변조되지 않았습니다." 또는 "변조 되었습니다."와 같은 적절한 텍스트가 표시됩니다.
""", imageView: UIImage(named: "WhiteAppIcon")!), animated: true)
            case 2:
                self.navigationController?.pushViewController(DetailExplanationViewController(mainTitleText: "탈옥이란?", explanationTitleText: "위험성", nameDetailTitleText: "- Apple 휴대용 기기에 사용되는 iOS 및 iPadOS의 제한을 임의로 해제하는 행위를 탈옥이라고 합니다.", explanationDetailTitleText: """
- iOS 탈옥이 아이폰을 여러 위험(보안 취약성, 안정성 문제, 갑자기 멈추거나 꺼지는 현상 발생 가능성)에 노출 시킬 수 있습니다.
- 탈옥 기기의 접근을 제한하지 않으면, 공격자가 마음대로 앱의 문제를 일으킬 수 있습니다.
""", imageView: UIImage(named: "WhiteAppIcon")!), animated: true)
            case 3:
                self.navigationController?.pushViewController(DetailExplanationViewController(mainTitleText: "앱 열기 추적이란?", explanationTitleText: "사용 이유", nameDetailTitleText: "- 앱을 열 때마다 앱을 언제 열었는지 추적하는 기능입니다.", explanationDetailTitleText: "사용자가 앱을 열면 앱을 연 날짜와 시간이 기록됩니다.", imageView: UIImage(named: "WhiteAppIcon")!), animated: true)
            case 4:
                self.navigationController?.pushViewController(DetailExplanationViewController(mainTitleText: "스크린샷 추적이란?", explanationTitleText: "사용 이유", nameDetailTitleText: "- 스크린샷을 찍을 때마다 언제 찍었는지 추적하는 기능입니다.", explanationDetailTitleText: "사용자가 스크린샷을 찍으면 언제 찍었는지 날짜와 시간을 표시합니다.", imageView: UIImage(named: "WhiteAppIcon")!), animated: true)
            case 5:
                self.navigationController?.pushViewController(DetailExplanationViewController(mainTitleText: "키체인이란?", explanationTitleText: "사용 이유", nameDetailTitleText: "- 암호화된 데이터베이스로서 개발자가 앱에서 중요한 데이터를 안전하게 저장하고 검색할 수 있는 기능을 제공합니다.", explanationDetailTitleText: "키체인을 사용하면 기기에서 암호와 기타 보안 정보를 업데이트된 상태로 안전하게 유지할 수 있습니다.", imageView: UIImage(named: "WhiteAppIcon")!), animated: true)
            case 6:
                self.navigationController?.pushViewController(DetailExplanationViewController(mainTitleText: "스크린샷 방지?", explanationTitleText: "사용 이유", nameDetailTitleText: "- 스크린 샷이 불가는 하도록하는 기능입니다.", explanationDetailTitleText: "스크린샷을 방지함으로써 민감한 개인정보를 보호합니다.", imageView: UIImage(named: "WhiteAppIcon")!), animated: true)
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                self.navigationController?.pushViewController(DetailExplanationViewController(mainTitleText: "웹 보안 정책이란?", explanationTitleText: "보안 정책 목록", nameDetailTitleText: """
    - 웹 보안 정책은 웹 사이트나 애플리케이션에서 적용되는 보안 관련 규칙과 지침의 모음이다.

    - 기업이나 조직이 웹 환경에서 보안을 강화하고 중요한 데이터와 시스템을 보호하기 위해 존재한다.

    - 웹 보안 정책은 다양한 측면을 다루며, 사용자 비밀번호 정책 외에도 액세스 제어, 데이터 보호, 암호화, 취약점 관리, 이상 행위 탐지 등을 다루는 경우가 많다.
""", explanationDetailTitleText: """
- 데이터 암호화
- 취약점 진단 및 관리
- 유저 패스워드 보안 강화
- 해외 아이피 차단
- 시간 당 요청 제한
- Request Body size Limit
""", imageView: UIImage(named: "Security1")!), animated: true)
            case 1:
                self.navigationController?.pushViewController(DetailExplanationViewController(mainTitleText: "해외 아이피 차단이란?", explanationTitleText: "마쉬멜로에서는", nameDetailTitleText: """
- 해외 아이피 차단은 뜻 그대로 해외에서 들어오는 IP의 모든 요청을 무시하는 것을 의미한다.

- 서버의 방화벽에서 요청이 들어올 때 마다 Client의 IP를 확인하여, 만약 국내 아이피가 아니라면 해당 요청을 차단하는 형태가 일반적이다.
""", explanationDetailTitleText: """
- 현재 국내에서 사용 가능한 통신사의 외부 아이피를 모두 리스트에 저장한 후 요청이 들어올 때 마다
    
- 리스트에 존재하는 아이피와 일치 여부를 확인하는 화이트 리스트 형식의 차단을 채택 중이다.
""", imageView: UIImage(named: "Security2")!), animated: true)
            default:
                break
            }
        default:
            break
        }
    }
}
