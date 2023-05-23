import UIKit
import Then
import SnapKit

class FileViewController: BaseEP {
    
    private lazy var presenter = FilePresenter(viewController: self, navigationController: navigationController!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWith(self)
        collectionView.dataSource = presenter
    }
    
    override func updateWith(_ controller: UIViewController) {
        super.updateWith(controller)
        
        customImageView.image = UIImage(named: "file")
    }
}

extension FileViewController: FileProtocol {
    func navigationSetup() {
        nameLabel.text = "용량"
    }
}
