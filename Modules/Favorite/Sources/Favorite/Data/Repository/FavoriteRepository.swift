//
//  FavoriteRepository.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 18/01/23.
//

import Foundation
import Combine
import Core

public final class FavoriteRepository: FavoriteRepositoryProtocol {
    private let favoriteDB: FavoriteGameProvider
    
    public init(favoriteDB: FavoriteGameProvider) {
        self.favoriteDB = favoriteDB
    }
    
    public func getAllFavorites(completion: @escaping ([GameModel]) -> Void) {
        return favoriteDB.getAllFavorites(completion: completion)
    }
    
    public func getFavoriteBySlug(slug: String, completion: @escaping (GameModel) -> Void) {
        return favoriteDB.getFavoriteBySlug(slug, completion: completion)
    }
    
    public func addFavorite(game: GameModel, completion: @escaping () -> Void) {
        return favoriteDB.addFavorite(game, completion: completion)
    }
    
    public func deleteFavoriteBySlug(slug: String, completion: @escaping () -> Void) {
        return favoriteDB.deleteFavorite(slug, completion: completion)
    }
}
