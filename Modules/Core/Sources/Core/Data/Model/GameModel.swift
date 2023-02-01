//
//  GameModel.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 13/01/23.
//

import Foundation

struct GameModel: Identifiable {
    let id: Int
    let slug: String
    let name: String
    let released: String
    let platforms: String
    let backgroundImage: String
    let rating: Double
    var isFavorite: Bool = false
}
