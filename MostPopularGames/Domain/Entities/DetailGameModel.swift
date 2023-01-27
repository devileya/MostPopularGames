//
//  DetailGameModel.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 13/01/23.
//

import Foundation

struct DetailGameModel: Identifiable {
    let id: Int
    let slug: String
    let name: String
    let released: String
    let platforms: String
    let genres: String
    let stores: String
    let description: String
    let developers: String
    let backgroundImage: String
    let rating: Double
    let metacritic: Int?
    let isFavorite: Bool
}
