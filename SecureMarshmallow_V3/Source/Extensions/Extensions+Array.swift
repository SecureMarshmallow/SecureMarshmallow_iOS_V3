import Foundation

public extension Array {
    func safeRef (_ index: Int) -> Element? {
        return 0 <= index && index < count ? self[index] : nil
    }
}
