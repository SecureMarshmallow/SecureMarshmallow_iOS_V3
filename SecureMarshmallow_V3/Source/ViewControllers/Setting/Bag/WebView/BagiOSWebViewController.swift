import UIKit
import WebKit

class BagiOSWebViewController: BaseWebView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "iOS 버그 제보"
        self.navigationItem.largeTitleDisplayMode = .never
        if let url = URL(string: "https://github.com/jjunhaa0211") {
            
            
            setupWebView(with: url)
        }
    }
}
