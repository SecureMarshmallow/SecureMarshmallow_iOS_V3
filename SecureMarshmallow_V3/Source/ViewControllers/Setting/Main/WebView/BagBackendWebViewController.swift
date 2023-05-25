//
//  BagBackendWebViewController.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/25.
//

import UIKit
import WebKit

class BagBackendWebViewController: BaseWebView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Backend 버그 제보"
        self.navigationItem.largeTitleDisplayMode = .never
        if let url = URL(string: "https://github.com/one3147") {
            setupWebView(with: url)
        }
    }
}


