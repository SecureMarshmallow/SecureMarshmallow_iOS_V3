//
//  Extensions+UIStackView.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/14.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ viewsToAdd: [UIView]) {
        viewsToAdd.forEach({addArrangedSubview($0)})
    }
}

