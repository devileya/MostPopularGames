//
//  GameRepository.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 18/01/23.
//

import Foundation
import Combine
import Core

public final class GameRepository: GameRepositoryProtocol {
    private let gameApi: GameApiProtocol
    private let favoriteDB: FavoriteGameProvider
    
    public init(gameApi: GameApiProtocol, favoriteDB: FavoriteGameProvider) {
        self.gameApi = gameApi
        self.favoriteDB = favoriteDB
    }
    
    public func getGames(ordering: String?, dates: String?, page: Int) -> AnyPublisher<MostPopularGamesResponse, Error> {
        return gameApi.getGames(ordering: ordering, dates: dates, page: page)
    }
}
