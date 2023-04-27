//
//  Extensions+UIView.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/04/27.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
