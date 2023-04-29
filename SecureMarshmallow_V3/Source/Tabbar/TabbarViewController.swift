import UIKit

class TapBarViewController: UITabBarController {
    private lazy var homeViewController: UINavigationController = {
        let viewController = SecureMarshmallow_V3.HomeViewController()
        let tabBarItem = UITabBarItem(title: "HOME", image: UIImage(systemName: "house.fill"), tag: 0)
        viewController.tabBarItem = tabBarItem
        let navigationView = UINavigationController(rootViewController: viewController)
        return navigationView
    }()
    
    private lazy var LockViewController: UIViewController = {
        let viewController = ListViewController()
        let tabBarItem = UITabBarItem(title: "lock", image: UIImage(systemName: "lock"), tag: 1)
        viewController.tabBarItem = tabBarItem
        let navigationView = UINavigationController(rootViewController: viewController)
        return navigationView
    }()
    
    private lazy var PhotoViewController: UIViewController = {
        let viewController = UIViewController()
        let tabBarItem = UITabBarItem(title: "photo", image: UIImage(systemName: "photo.fill"), tag: 2)
        viewController.tabBarItem = tabBarItem
        let navigationView = UINavigationController(rootViewController: viewController)
        return navigationView
    }()
    
    private lazy var SettingsViewController: UIViewController = {
        let viewController = SecureMarshmallow_V3.SettingsViewController()
        let tabBarItem = UITabBarItem(title: "setting", image: UIImage(systemName: "gear"), tag: 2)
        viewController.tabBarItem = tabBarItem
        let navigationView = UINavigationController(rootViewController: viewController)
        return navigationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [homeViewController,
                           LockViewController,
                           PhotoViewController,
                           SettingsViewController]
        configureTabBar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        var tabFrame = tabBar.frame
        if UIScreen.main.bounds.height <= 667 {
            // iPhone 5s, SE
            tabFrame.size.height = 50
        } else {
            // iPhone 6, 6s, 7, 8, X, Xs, 11 Pro
            tabFrame.size.height = 70
        }
        tabBar.frame = tabFrame
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
