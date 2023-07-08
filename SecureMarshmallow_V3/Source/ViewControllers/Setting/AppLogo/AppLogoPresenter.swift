import SnapKit
import Then

protocol AppLogoProtocol: AnyObject {
    func layout()
    func attribute()
    func navigation()
}

class AppLogoPresenter: NSObject {
    private let viewController: AppLogoProtocol?
    private let navigationController: UINavigationController
    
    init(viewController: AppLogoProtocol,
         navigationController: UINavigationController) {
        self.viewController = viewController
        self.navigationController = navigationController
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
    
    func viewDidLoad() {
        viewController?.layout()
        viewController?.attribute()
        viewController?.navigation()
    }
}

extension AppLogoPresenter: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppLogoCell.identifier, for: indexPath) as! AppLogoCell
                
        if indexPath.row == 0 {
            cell.appLogoView.image = UIImage(named: "logo\(indexPath.row)")
        }
        
        if indexPath.row == 1 {
            cell.appLogoView.image = UIImage(named: "logo\(indexPath.row)")
        }
        
        if indexPath.row == 2 {
            cell.appLogoView.image = UIImage(named: "logo\(indexPath.row)")
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            changeAppIcon(to: "BlackAppIcon")
        }
        
        if indexPath.row == 1 {
            changeAppIcon(to: "WhiteAppIcon")
        }
        
        if indexPath.row == 2 {
            changeAppIcon(to: "OldAppIcon")
        }
    }
}

extension AppLogoPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 10
        let totalSpacing: CGFloat = (2 * spacing) + (2 * spacing)
        let cellWidth = (collectionView.bounds.width - totalSpacing) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
