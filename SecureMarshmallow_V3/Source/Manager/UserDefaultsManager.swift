//import Foundation
//
//protocol UserDefaultsManagerProtocol {
//    func getReviews() -> [MemoData]
//    func setReview(_ newValue: MemoData)
//}
//
//struct UserDefaultsManager: UserDefaultsManagerProtocol {
//    
//    enum Key: String {
//        case review
//    }
//    
//    func getReviews() -> [MemoData] {
//        guard let data = UserDefaults.standard.data(forKey: Key.review.rawValue) else { return [] }
//        
//        return (try? PropertyListDecoder().decode([MemoData].self, from: data)) ?? []
//    }
//    
//    func setReview(_ newValue: MemoData) {
//        var currentReviews: [MemoData] = getReviews()
//        currentReviews.insert(newValue, at: 0)
//        
//        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(currentReviews),
//                                       forKey: Key.review.rawValue)
//    }
//}
