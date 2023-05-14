//
//  Extensions+UIColor.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/11.
//

import UIKit

extension UIColor {
    static let BackGray: UIColor = UIColor(named: "BackgroundViewColor")!
    static let cellColor: UIColor = UIColor(named: "CollectioinViewCellColor")!
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    static var sit_PrimaryLight: UIColor {
//        return UIColor(hexString: "#7b2c82")
        return UIColor(hexString: "#000000")
    }
    static var sit_Primary: UIColor {
//        return UIColor(hexString: "#791f82")
        return UIColor(hexString: "#000000")
    }
    
    static var sit_Inactive: UIColor {
//        return UIColor(hexString: "#545454")
        return UIColor(hexString: "#000000")
    }
}
