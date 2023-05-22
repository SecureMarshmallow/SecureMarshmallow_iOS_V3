import Foundation
import UIKit

final class ImageCache {
  static let shared = NSCache<NSString, UIImage>()
  
  private init() {}
}
