//
//  WriteView.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/06/08.
//

import UIKit
import Then
import SnapKit

class WriteView: BaseView {
    
    public lazy var textView = UITextView().then {
        $0.textContainerInset = UIEdgeInsets(top: 24, left: 20, bottom: 20, right: 20)
        $0.font = .boldSystemFont(ofSize: 14)
        $0.isScrollEnabled = true
    }

    override func setupUI() {
        self.addSubview(textView)
    }
    
    override func setConstraints() {
        textView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
