//
//  AddGameFavoriteUC.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 19/01/23.
//

import Foundation
import Core

public protocol AddGameFavoriteUC {
    func execute(game: GameModel, completion: @escaping () -> Void)
}

public final class AddGameFavorite: AddGameFavoriteUC {
    private let repository: FavoriteRepositoryProtocol
    
    public init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(game: GameModel, completion: @escaping () -> Void) {
        return repository.addFavorite(game: game, completion: completion)
    }
}
