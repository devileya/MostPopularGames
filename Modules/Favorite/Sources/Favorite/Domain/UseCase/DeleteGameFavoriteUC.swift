//
//  DeleteGameFavoriteUC.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 19/01/23.
//

import Foundation

protocol DeleteGameFavoriteUC {
    func execute(slug: String, completion: @escaping () -> Void)
}

final class DeleteGameFavorite: DeleteGameFavoriteUC {
    private let gameRepository: GameRepositoryProtocol
    
    init(gameRepository: GameRepositoryProtocol) {
        self.gameRepository = gameRepository
    }
    
    func execute(slug: String, completion: @escaping () -> Void) {
        return gameRepository.deleteFavoriteBySlug(slug: slug, completion: completion)
    }
}
