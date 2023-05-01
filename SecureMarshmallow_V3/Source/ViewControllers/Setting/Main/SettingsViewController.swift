import UIKit

class SettingsViewController: BaseSV {

    // MARK: - Properties
    
    private var settingsItems: [[SettingsItem]] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSettingsItems()
    }

    // MARK: - Helpers

    override func configureUI() {
        super.configureUI()
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func configureItems() {
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)
    }

    private func configureSettingsItems() {
        let section1 = [SettingsItem(type: .gmailInformation),
                        SettingsItem(type: .idInformation)]
        let section2 = [SettingsItem(type: .appPassword),
                        SettingsItem(type: .intrusionInformation),
                        SettingsItem(type: .appTracking)]

        let section3 = [SettingsItem(type: .changeAppIcon),
                        SettingsItem(type: .changeAppTheme)]

        let section4 = [SettingsItem(type: .help),
                        SettingsItem(type: .bugReport)]

        let section5 = [SettingsItem(type: .feedback)]

        let section6 = [SettingsItem(type: .appShare),
                        SettingsItem(type: .privacyPolicy),
                        SettingsItem(type: .termsofUse)]

        let section7 = [SettingsItem(type: .howToUse),
                        SettingsItem(type: .developerIformation)]

        settingsItems = [section1, section2, section3, section4, section5, section6, section7]
    }
}

// MARK: - UITableViewDataSource

extension SettingsViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return settingsItems.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsItems[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let item = settingsItems[indexPath.section][indexPath.row]
        cell.textLabel?.text = item.type.title
        return cell
    }

}

// MARK: - UITableViewDelegate

extension SettingsViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)

        tableView.deselectRow(at: indexPath, animated: true)

        let item = settingsItems[indexPath.section][indexPath.row]
        switch item.type {
        case .gmailInformation:
            let gmailVC = GmailInformationViewController()
            gmailVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(gmailVC, animated: true)
            break
        case .idInformation:
            print("id")
            break
        case .intrusionInformation:
            break
        case .appPassword:
            break
        case .appTracking:
            let timeOfAppVC = TimeOfAppViewController()
            timeOfAppVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(timeOfAppVC, animated: true)
            break
        case .changeAppIcon:
            let applogoVC = AppLogoViewController()
            applogoVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(applogoVC, animated: true)
            print("앱 아이콘 변경")
        case .changeAppTheme:
            print("앱 테마 변경 클릭")
        case .help:
            let supportVC = SupportViewController()
            supportVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(supportVC, animated: true)
            print("지원")
        case .bugReport:
            print("버그 제보")
        case .feedback:
            print("피드백")
        case .appShare:
            print("앱 공유")
        case .privacyPolicy:
            print("개인정보 처리 방침")
        case .termsofUse:
            print("이용 약관 클릭")
        case .howToUse:
            print("사용 방법")
        case .developerIformation:
            print("개발자 정보")
            let devlopersVC = DevelopersViewController()
            devlopersVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(devlopersVC, animated: true)
        }
    }

}
