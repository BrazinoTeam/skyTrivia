//
//  AuthRequestService.swift

import Foundation

class TokenService {
    
    static let shared = TokenService()
    
    var token: String?
    
    let username = "admin"
    let password = "ofQ87Sl172kL"
    let loggo = "siso"
    let url = URL(string: "https://sky-trivia-backend-b774792391ad.herokuapp.com/login")!
    var request: URLRequest
    
    init() {
        request = URLRequest(url: url)
        request.httpMethod = "POST"
        let loginString = "\(username):\(password)"
        if let loginData = loginString.data(using: String.Encoding.utf8) {
            let base64LoginString = loginData.base64EncodedString(options: [])
            request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        }
    }
    
    struct AuthResponse: Codable {
        let token: String?
    }

    func authenticate() async throws {
        do {
            let config = URLSessionConfiguration.default
                   config.urlCache = nil
                   config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
                   let session = URLSession(configuration: config)
            let (data, _) = try await session.data(for: request)
            let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
            self.token = authResponse.token
            print("token -- \(token)")
        } catch {
            throw error
        }
    }
    
}

