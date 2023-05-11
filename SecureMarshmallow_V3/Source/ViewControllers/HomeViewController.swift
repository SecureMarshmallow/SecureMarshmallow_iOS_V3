import UIKit
import Then

class HomeViewController: UIViewController {
    
    private lazy var navLabel = UILabel().then {
        $0.textColor = UIColor.black
        $0.text = "SecureMarshmallow"
        $0.font = .systemFont(ofSize: 24.0, weight: .bold)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        view.backgroundColor = .white
    }
    
    func configureUI() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: navLabel)
        self.navigationItem.leftItemsSupplementBackButton = true
    }
}
