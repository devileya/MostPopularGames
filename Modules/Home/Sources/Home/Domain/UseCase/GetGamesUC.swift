//
//  GetGames.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 19/01/23.
//

import Foundation
import Combine
import Core
import Favorite

public protocol GetGamesUC {
    func execute(request: getGamesUCRequest, nextPage: @escaping (Int) -> Void, completion: @escaping ([GameModel]) -> Void)
}

public final class GetGames: GetGamesUC {
    private let gameRepository: GameRepositoryProtocol
    private let favoriteRepository: FavoriteRepositoryProtocol
    
    public init(gameRepository: GameRepositoryProtocol, favoriteRepository: FavoriteRepositoryProtocol) {
        self.gameRepository = gameRepository
        self.favoriteRepository = favoriteRepository
    }
    
    private var cancellable: AnyCancellable? = nil
    
    public func execute(request: getGamesUCRequest, nextPage: @escaping (Int) -> Void, completion: @escaping ([GameModel]) -> Void) {
        
        if (request.page == -1) {
            print("you got the last page")
            return
        }
        
        favoriteRepository.getAllFavorites { favoriteGames in
            DispatchQueue.main.async {
                self.cancellable = self.gameRepository.getGames(ordering: request.ordering, dates: request.dates, page: request.page)
                    .sink(receiveCompletion: { [weak self] status in
                        switch status {
                        case .failure:
                            print("failed to get API \(status)")
                        case .finished:
                            print("success get API")
                        }
                        self?.cancellable?.cancel()
                    }, receiveValue: { response in
                        nextPage(response.next != nil ? request.page+1 : -1)
                        completion(self.gameResultToGameModel(gameResults: response.results, favoriteGames: favoriteGames))
                    })
            }
        }
        
    }
    
    private func gameResultToGameModel(gameResults: [GameResult], favoriteGames: [GameModel]?) -> [GameModel] {
        gameResults.map { game in
            let platforms = game.platforms.map { $0.platform.name ?? ""}.joined(separator: ", ")
            let isFavorite = favoriteGames?.contains(where: { item in
                item.slug == game.slug
            })
            
            return GameModel(
                id: game.id,
                slug: game.slug,
                name: game.name,
                released: game.released,
                platforms: platforms,
                backgroundImage: game.backgroundImage ?? "",
                rating: game.rating,
                isFavorite: isFavorite ?? false
            )
        }
    }
}

public struct getGamesUCRequest {
    let ordering: String
    let dates: String
    let page: Int
}
