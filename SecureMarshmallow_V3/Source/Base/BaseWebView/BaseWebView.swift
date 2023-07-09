import UIKit
import WebKit

class BaseWebView: UIViewController, UIScrollViewDelegate {
    private var webView: WKWebView?
    private var navigationBarHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url: URL = URL(string: "https://ddddddd//ddddd")!
        setupWebView(with: url)
        
        self.navigationItem.largeTitleDisplayMode = .never
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setupWebView(with url: URL) {
        webView = WKWebView(frame: view.bounds)
        webView?.scrollView.delegate = self
        
        let urlRequest = URLRequest(url: url)
        webView?.load(urlRequest)
        
        if let webView = webView {
            view.addSubview(webView)
            
            webView.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.trailing.leading.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
        }
    }
    
    // UIScrollViewDelegate 메서드 구현
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let navigationBar = navigationController?.navigationBar

        if offsetY > 0 && !navigationBarHidden {
            navigationBar?.isHidden = true
            navigationBarHidden = true
        } else if offsetY < 0 && navigationBarHidden {
            navigationBar?.isHidden = false
            navigationBarHidden = false
        }
    }
}
