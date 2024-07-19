//
//  AirplaneModel.swift

import Foundation

struct AirplaneModel: Decodable {
    struct Airplane: Decodable {
        
        struct Quiz: Decodable {
            
            struct Question: Decodable {
                struct Variant: Decodable {
                    var text: String
                    var isRight: Bool
                }
                var question: String
                var variants: [Variant]
            }
            
            var quizDurationMinutes: Int
            var questions: [Question]
        }
        
        var id: Int
        var name: String
        var photoName: String
        var info: String
        var infoDurationMinutes: Int
        var quiz: Quiz
    }
    
    var airplanes: [Airplane]
}

extension AirplaneModel {
    
    static func getAirplanetFromFile() -> [AirplaneModel.Airplane] {
        guard let url = Bundle.main.url(forResource: "jsonData", withExtension: "json") else {
            return []
        }
        guard let data = try? Data(contentsOf: url) else {
            return []
        }
        guard let model = try? JSONDecoder().decode(AirplaneModel.self, from: data) else {
            return []
        }
        return model.airplanes
    }
    
}
