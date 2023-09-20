import SnapKit
import Then
import UIKit

enum NetworkError: Error {
    case noData
    case invalidResponse
    case authenticationFailed
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func login(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let baseURL = "https://2c33-2001-4430-c03f-3e17-b453-85f4-c1a8-643f.ngrok-free.app/"
        let loginURL = URL(string: baseURL + "api/login")!
        
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters = [
            "id": username,
            "password": password
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let success = json["success"] as? Bool, success {
                        if let token = json["access_token"] as? String {
                            completion(.success(token))
                        } else {
                            completion(.failure(NetworkError.invalidResponse))
                        }
                    } else {
                        completion(.failure(NetworkError.authenticationFailed))
                    }
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
