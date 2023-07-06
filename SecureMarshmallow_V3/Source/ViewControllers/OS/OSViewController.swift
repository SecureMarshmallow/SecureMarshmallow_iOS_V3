import UIKit
import SnapKit

class OSViewController: BaseEP {
    
    private lazy var presenter = OSPresenter(viewController: self, navigationController: navigationController!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWith(self)
        collectionView.dataSource = presenter
    }
    
    override func updateWith(_ controller: UIViewController) {
        super.updateWith(controller)
        customImageView.image = UIImage(named: "iPhone")
    }
}

extension OSViewController: OSProtocol {
    
    func navigationSetup() {
        nameLabel.text = "iOS"
    }
}
