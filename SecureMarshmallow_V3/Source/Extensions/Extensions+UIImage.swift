//
//  Extensions+UIImage.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/25.
//

import Foundation
import UIKit

extension UIImage {
    func resized(toWidth width: CGFloat, height: CGFloat) -> UIImage? {
        let newSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func roundedImage(withRadius radius: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        let bounds = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: bounds, cornerRadius: radius).addClip()
        draw(in: bounds)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
