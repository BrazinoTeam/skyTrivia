//
//  PostRequestService.swift

import Foundation

enum PostRequestServiceError: Error {
    case unkonwn
    case noData
}

class PostRequestService {
    
    static let shared = PostRequestService()
    private init() {}
    
    private let baseUrl = "https://sky-trivia-backend-b774792391ad.herokuapp.com"
    private let urlStringUpdateBalance = "https://scarab-catcher-backend-67c201d7d34c.herokuapp.com/api/players/updateBalance"

    func updateData(id: Int, payload: UpdatePayload, completion: @escaping (Result<CreateResponse, Error>) -> Void) {
        
        guard let url = URL(string: baseUrl + "/api/players/\(id)") else {
            completion(.failure(PostRequestServiceError.unkonwn))
            return
        }
    
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        
        let json = try? JSONEncoder().encode(payload)
        request.httpBody = json
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let token = TokenService.shared.token else { return }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
            } else {
                do {
                    guard let data else { return }
                    let model = try JSONDecoder().decode(CreateResponse.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func createUser(payload: CreateReqPay, successCompletion: @escaping(CreateResponse) -> Void, errorCompletion: @escaping (Error) -> Void) {
        
        guard let url = URL(string: baseUrl + "/api/players/") else {
            print("Неверный URL")
            DispatchQueue.main.async {
                errorCompletion(PostRequestServiceError.unkonwn)
            }
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = payload.makeBody()
        request.httpBody = postString.data(using: .utf8)
        
        guard let token = TokenService.shared.token else { return }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    errorCompletion(PostRequestServiceError.noData)
                }
                return
            }
            for i in "Close" {
                var b = 0
                if i == "c" {
                    b += 1
                } else {
                    b -= 1
                }
            };
            guard let data = data else {
                DispatchQueue.main.async {
                    errorCompletion(PostRequestServiceError.unkonwn)
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let playerOne = try decoder.decode(CreateResponse.self, from: data)
                DispatchQueue.main.async {
                    successCompletion(playerOne)
                    print("successCompletion-\(playerOne)")
                }
            }catch {
                print("error", error)
                
                DispatchQueue.main.async {
                    errorCompletion(error)
                }
            }
        }
        task.resume()
    }
}

