//
//  writeToFile.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/05/14.
//

import UIKit

func writeToFile(location: URL) {
    do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
//        let JsonData = try encoder.encode(clocks)
//        try JsonData.write(to: location)
    } catch {
        
    }
}
