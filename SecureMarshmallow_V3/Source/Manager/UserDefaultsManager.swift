import Foundation

protocol UserDefaultsManagerProtocol {
    func getReviews() -> [SavePassword]
    func setReview(_ newValue: SavePassword)
}

struct UserDefaultsManager: UserDefaultsManagerProtocol {
    
    enum Key: String {
        case review
    }
    
    func getReviews() -> [SavePassword] {
        guard let data = UserDefaults.standard.data(forKey: Key.review.rawValue) else { return [] }
        
        return (try? PropertyListDecoder().decode([SavePassword].self, from: data)) ?? []
    }
    
    func setReview(_ newValue: SavePassword) {
        var currentReviews: [SavePassword] = getReviews()
        currentReviews.insert(newValue, at: 0)
        
        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(currentReviews),
                                       forKey: Key.review.rawValue)
    }
}
