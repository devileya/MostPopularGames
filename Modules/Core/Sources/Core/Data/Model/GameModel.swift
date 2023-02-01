//
//  GameModel.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 13/01/23.
//

import Foundation

public struct GameModel: Identifiable {
    public let id: Int
    public let slug: String
    public let name: String
    public let released: String
    public let platforms: String
    public let backgroundImage: String
    public let rating: Double
    public var isFavorite: Bool = false
    
    public init(id: Int, slug: String, name: String, released: String, platforms: String, backgroundImage: String, rating: Double, isFavorite: Bool?) {
        self.id = id
        self.slug = slug
        self.name = name
        self.released = released
        self.platforms = platforms
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.isFavorite = isFavorite ?? false
    }
}
