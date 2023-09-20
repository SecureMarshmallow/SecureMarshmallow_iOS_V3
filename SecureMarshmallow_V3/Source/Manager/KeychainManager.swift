import Foundation
import UIKit

public class KeychainManager {
    private let service: String
    
    public init(service: String) {
        self.service = service
    }
    
    public func storeToken(_ token: String, forKey key: String) -> OSStatus {
        guard let data = token.data(using: .utf8) else { return errSecParam }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    public func token(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue!
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess, let tokenData = dataTypeRef as? Data {
            return String(data: tokenData, encoding: .utf8)
        } else {
            return nil
        }
    }
    
    public func getToken(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue as Any
        ]

        var retrievedData: AnyObject? = nil
        let status = SecItemCopyMatching(query as CFDictionary, &retrievedData)

        if status == errSecSuccess, let cfData = retrievedData as? Data {
            return String(data: cfData, encoding: .utf8)
        }

        return nil
    }
}

