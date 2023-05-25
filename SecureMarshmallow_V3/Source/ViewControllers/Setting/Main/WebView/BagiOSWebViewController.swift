//
//  BagWebViewController.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/25.
//

import UIKit
import WebKit

class BagiOSWebViewController: BaseWebView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "버그 제보"
        if let url = URL(string: "https://github.com/jjunhaa0211") {
            setupWebView(with: url)
        }
    }
}
