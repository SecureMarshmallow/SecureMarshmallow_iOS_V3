import UIKit

protocol TimeOfAppProtocol: AnyObject {
    func dataFormatter()
    func navigationSetup()
    func tableViewSetup()
    func resetButtonTap()
}

class TimeOfAppPresenter: NSObject {
    private let viewController: TimeOfAppProtocol
    private let navigationController: UINavigationController
    
    init(viewController: TimeOfAppProtocol, navigationController: UINavigationController) {
        self.viewController = viewController
        self.navigationController = navigationController
    }
    
    func viewDidLoad() {
        viewController.tableViewSetup()
        viewController.dataFormatter()
        viewController.navigationSetup()
    }
}
