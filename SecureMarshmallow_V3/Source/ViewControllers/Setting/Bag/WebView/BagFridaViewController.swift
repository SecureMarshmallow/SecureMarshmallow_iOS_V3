import UIKit
import WebKit

class BagFridaViewController: BaseWebView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.largeTitleDisplayMode = .never
        if let url = URL(string: "https://github.com/wldms615") {
            setupWebView(with: url)
        }
    }
}
