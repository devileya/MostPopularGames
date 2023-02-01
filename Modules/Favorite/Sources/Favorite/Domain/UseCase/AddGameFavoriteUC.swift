//
//  AddGameFavoriteUC.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 19/01/23.
//

import Foundation

protocol AddGameFavoriteUC {
    func execute(game: GameModel, completion: @escaping () -> Void)
}

final class AddGameFavorite: AddGameFavoriteUC {
    private let gameRepository: GameRepositoryProtocol
    
    init(gameRepository: GameRepositoryProtocol) {
        self.gameRepository = gameRepository
    }
    
    func execute(game: GameModel, completion: @escaping () -> Void) {
        return gameRepository.addFavorite(game: game, completion: completion)
    }
}
