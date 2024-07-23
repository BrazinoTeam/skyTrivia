//
//  GetRequestService.swift


import Foundation

enum GetRequestServiceError: Error {
    case unkonwn
    case noData
}

class GetRequestService {

    static let shared = GetRequestService()
    
    private init() {}
    
    private let urlString = "https://sky-trivia-backend-b774792391ad.herokuapp.com/api/players"
    private let urlStringUpdateBalance = "https://sky-trivia-backend-b774792391ad.herokuapp.com/api/players/updateBalance"

    func getLeadeboards(successCompletion: @escaping([User]) -> Void, errorCompletion: @escaping (Error) -> Void) {

        guard let url = URL(string: urlString) else {
            print("Неверный URL")
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
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
     
        
        guard let token = TokenService.shared.token else { return }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    errorCompletion(GetRequestServiceError.noData)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    errorCompletion(GetRequestServiceError.unkonwn)
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let players = try decoder.decode([User].self, from: data)
                DispatchQueue.main.async {
                    successCompletion(players)
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
