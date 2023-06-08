//
//  BaseView.swift
//  Pods
//
//  Created by 박준하 on 2023/06/08.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func setupUI() { }
    func setConstraints() { }

}
