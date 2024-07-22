//
//  User.swift


import Foundation

struct User: Codable {
    let id: Int?
    let imageURL: String?
    let score: Int
    let name: String?
    let balance: Int?
    let bubleLabel: String?
    let gyms: String?
}
