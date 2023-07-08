import UIKit
import SnapKit

protocol BagProtocol: AnyObject {
    func attribute()
    func configureSettingsItems()
    func navigationSetup()
}

class BagPresenter: NSObject {
    private let viewController: BagProtocol
    private let navigationController: UINavigationController
    
    init(viewController: BagProtocol, navigationController: UINavigationController) {
        self.viewController = viewController
        self.navigationController = navigationController
    }
    
    func viewDidLoad() {
        viewController.attribute()
        viewController.configureSettingsItems()
        viewController.navigationSetup()
    }
}
