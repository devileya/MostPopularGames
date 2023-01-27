//
//  GetAllFavoritesUC.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 19/01/23.
//

import Foundation

protocol GetGameFavoriteUC {
    func execute(completion: @escaping ([GameModel]) -> Void)
    func executeBySlug(slug: String, completion: @escaping (GameModel) -> Void)
}

final class GetGameFavorite: GetGameFavoriteUC {
    private let gameRepository: GameRepositoryProtocol
    
    init(gameRepository: GameRepositoryProtocol) {
        self.gameRepository = gameRepository
    }
    
    func execute(completion: @escaping ([GameModel]) -> Void) {
        return gameRepository.getAllFavorites(completion: completion)
    }
    
    func executeBySlug(slug: String, completion: @escaping (GameModel) -> Void) {
        return gameRepository.getFavoriteBySlug(slug: slug, completion: completion)
    }
}
