//
//  Games.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 09/01/23.
//

import Core

// MARK: - Game
struct GameResult: Codable, Identifiable {
    let slug, name: String
    let playtime: Int
    let platforms: [Platform]
    let released: String
    let tba: Bool
    let backgroundImage: String?
    let rating: Double
    let ratingTop: Int
    let ratings: [Rating]
    let ratingsCount, reviewsTextCount, added: Int
    let addedByStatus: AddedByStatus
    let metacritic, suggestionsCount: Int?
    let updated: String
    let id: Int
    let score, clip: String?
    let tags: [Tag]
    let reviewsCount: Int
    let saturatedColor, dominantColor: String
    let shortScreenshots: [ShortScreenshot]
    let parentPlatforms: [Platform]
    let genres: [Genre]

    enum CodingKeys: String, CodingKey {
        case slug, name, playtime, platforms, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case addedByStatus = "added_by_status"
        case metacritic
        case suggestionsCount = "suggestions_count"
        case updated, id, score, clip, tags
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case shortScreenshots = "short_screenshots"
        case parentPlatforms = "parent_platforms"
        case genres
    }
}

// MARK: - AddedByStatus
struct AddedByStatus: Codable {
    let yet, owned, beaten, toplay: Int?
    let dropped, playing: Int?
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name, slug: String?
}

// MARK: - Platform
struct Platform: Codable {
    let platform: Genre
}

// MARK: - Rating
struct Rating: Codable {
    let id: Int
    let title: String
    let count: Int
    let percent: Double
}

// MARK: - ShortScreenshot
struct ShortScreenshot: Codable {
    let id: Int
    let image: String
}

// MARK: - Store
struct Store: Codable {
    let store: Genre?
}

// MARK: - Tag
struct Tag: Codable {
    let id: Int
    let name, slug: String
    let language: Language
    let gamesCount: Int
    let imageBackground: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug, language
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}
