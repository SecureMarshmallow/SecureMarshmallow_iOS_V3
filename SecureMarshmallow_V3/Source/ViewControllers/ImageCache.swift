//
//  ImageCache.swift
//  SecureMarshmallow_V3
//
//  Created by 박준하 on 2023/04/29.
//

import Foundation
import UIKit

final class ImageCache {
  static let shared = NSCache<NSString, UIImage>()
  
  private init() {}
}
