//
//  GameRepository.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 18/01/23.
//

import Foundation
import Combine

final class GameRepository: GameRepositoryProtocol {
    private let gameApi: GameApiProtocol
    private let favoriteDB: FavoriteGameProvider
    
    init(gameApi: GameApiProtocol, favoriteDB: FavoriteGameProvider) {
        self.gameApi = gameApi
        self.favoriteDB = favoriteDB
    }
    
    func getGames(ordering: String?, dates: String?, page: Int) -> AnyPublisher<MostPopularGamesResponse, Error> {
        return gameApi.getGames(ordering: ordering, dates: dates, page: page)
    }
    
    func getDetailGame(slug: String) -> AnyPublisher<DetailGameResponse, Error> {
        return gameApi.getDetailGame(slug: slug)
    }
    
    func getAllFavorites(completion: @escaping ([GameModel]) -> Void) {
        return favoriteDB.getAllFavorites(completion: completion)
    }
    
    func getFavoriteBySlug(slug: String, completion: @escaping (GameModel) -> Void) {
        return favoriteDB.getFavoriteBySlug(slug, completion: completion)
    }
    
    func addFavorite(game: GameModel, completion: @escaping () -> Void) {
        return favoriteDB.addFavorite(game, completion: completion)
    }
    
    func deleteFavoriteBySlug(slug: String, completion: @escaping () -> Void) {
        return favoriteDB.deleteFavorite(slug, completion: completion)
    }
}
