//
//  MostPopularGamesResponse.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 09/01/23.
//

import Foundation

public struct MostPopularGamesResponse: Codable, Identifiable {
    public let id = UUID().uuidString
    let count: Int
    let next: String?
    let previous: String?
    let results: [GameResult]
    
    enum CodingKeys: String, CodingKey {
        case id, count, next, previous, results
    }
}
