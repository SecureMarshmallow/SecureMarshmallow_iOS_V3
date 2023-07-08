import UIKit
import WebKit

class PrivacyViewController: BaseWebView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "개인정보 보호 정책"
        
        self.navigationItem.largeTitleDisplayMode = .never
        if let url = URL(string: "https://www.notion.so/bbd0793632644b1381dc2c41939bb773") {
            
            setupWebView(with: url)
        }
    }
}
