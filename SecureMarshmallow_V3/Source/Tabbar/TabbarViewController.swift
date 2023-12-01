import UIKit

class TapBarViewController: UITabBarController {
    
    private lazy var homeViewController: UINavigationController = {
        let viewController = HomeViewController()
        let tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Home_TapBar_Gray"), tag: 0)
        viewController.tabBarItem = tabBarItem
        let navigationView = UINavigationController(rootViewController: viewController)
        return navigationView
    }()
    
    private lazy var lockViewController: UIViewController = {
        let viewController = MemoListViewController()
        let tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Password_TapBar_Gray"), tag: 1)
        viewController.tabBarItem = tabBarItem
        let navigationView = UINavigationController(rootViewController: viewController)
        return navigationView
    }()
    
    private lazy var photoViewController: UIViewController = {
        let viewController = ImageFileViewController()
        let tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Photo_TapBar_Gray"), tag: 2)
        viewController.tabBarItem = tabBarItem
        let navigationView = UINavigationController(rootViewController: viewController)
        return navigationView
    }()
    
    private lazy var settingsViewController: UIViewController = {
        let viewController = SecureMarshmallow_V3.SettingsViewController()
        let tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Setting_TapBar_Gray"), tag: 3)
        viewController.tabBarItem = tabBarItem
        let navigationView = UINavigationController(rootViewController: viewController)
        return navigationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [homeViewController,
                           lockViewController,
                           photoViewController,
                           settingsViewController]
        configureTabBar()
    }
}

extension UITabBarController {
    
    func configureTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = UIColor.clear
        appearance.backgroundColor = .white
        
        tabBar.standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
            //tabbar 불투명도
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        
        self.tabBar.layer.cornerRadius = 8
        self.tabBar.layer.backgroundColor = UIColor.systemBackground.cgColor
        self.tabBar.tintColor = .black
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 6
    }
}
