import UIKit
import SnapKit

class OSViewController: BaseEP {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWith(self)
        collectionView.dataSource = self
    }
    
    override func updateWith(_ controller: UIViewController) {
        super.updateWith(controller)
        
        nameLabel.text = "iOS"
        customImageView.image = UIImage(named: "iPhone")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
    }
}
