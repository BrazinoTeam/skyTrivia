//
//  MemoryApp.swift

import Foundation
class MemoryApp {
    
    static let shared = MemoryApp()
    
    private let defaults = UserDefaults.standard
    
    var scorePoints: Int {
        get {
            return defaults.integer(forKey: "scorePoints", defaultValue: 1500)
        }
        set {
            defaults.set(newValue, forKey: "scorePoints")
        }
    }
    
    var answerQuestions: Int {
        get {
            return defaults.integer(forKey: "answerQuestions", defaultValue: 0)
        }
        set {
            defaults.set(newValue, forKey: "answerQuestions")
        }
    }
    
    var lastBonusDate: Date? {
        get {
            return defaults.object(forKey: "lastBonusDate") as? Date
        }
        set {
            defaults.set(newValue, forKey: "lastBonusDate")
        }
    }
    
    var firstLaunchDate: Date? {
        get {
            return defaults.object(forKey: "firstLaunchDate") as? Date
        }
        set {
            defaults.set(newValue, forKey: "firstLaunchDate")
        }
    }
    
    var userName: String? {
        get {
            return defaults.string(forKey: "userName")
        }
        set {
            defaults.set(newValue, forKey: "userName")
        }
    }
    
    var userID: Int? {
        get {
            return defaults.object(forKey: "userID") as? Int
        }
        set {
            defaults.set(newValue, forKey: "userID")
        }
    }
}

extension UserDefaults {
    func integer(forKey key: String, defaultValue: Int) -> Int {
        return self.object(forKey: key) as? Int ?? defaultValue
    }
}
