//
//  Extensions+UILabel.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/06/08.
//

import Foundation
import UIKit

extension UILabel {
    public func labelColorChange(_ query: String ) {
        guard let wholeString = self.text else {
            print("레이블에 문자열이 없습니다")
            return }
        
        let customColor = UIColor.black
        
        let attributedString = NSMutableAttributedString(string: wholeString)
        let entireLength = wholeString.count
        var range = NSRange(location: 0, length: entireLength)
        
        var rangeArray = [NSRange]()
        
        while (range.location != NSNotFound) {
            range = (attributedString.string as NSString).range(of: query, options: .caseInsensitive, range: range)
            rangeArray.append(range)
            if range.location != NSNotFound {
                let location = range.location + range.length
                range = NSRange(location: location  , length: entireLength - location)
            }
        }
        
        rangeArray.indices.forEach { index in
            attributedString.addAttribute(.foregroundColor, value: customColor, range: rangeArray[index])
        }

        self.attributedText = attributedString
    }
}
