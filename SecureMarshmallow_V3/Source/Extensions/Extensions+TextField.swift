//
//  Extensions+TextField.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/06/04.
//

import Foundation
import UIKit

extension UITextField {
    func setPlaceholder(color: UIColor) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
}
