//
//  GameContainer.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 13/01/23.
//

import Foundation
import Swinject

extension Container {
    static let gameContainer: Container = {
        let container = Container()
        
        // Data Source
        container.register(ApiClient.self, factory: {_ in ApiClient()})
        container.register(GameApiProtocol.self, factory: {r in
            GameApi(client: r.resolve(ApiClient.self)!)
        })
        container.register(FavoriteGameProvider.self) { _ in
            FavoriteGameProvider()
        }
        
        // Repositories
        container.register(GameRepositoryProtocol.self) { r in
            GameRepository(gameApi: r.resolve(GameApiProtocol.self)!, favoriteDB: r.resolve(FavoriteGameProvider.self)!)
        }
        
        // Use Cases
        container.register(GetGamesUC.self) { r in
            GetGames(gameRepository: r.resolve(GameRepositoryProtocol.self)!)
        }
        container.register(GetDetailGameUC.self) { r in
            GetDetailGame(gameRepository: r.resolve(GameRepositoryProtocol.self)!)
        }
        container.register(GetGameFavoriteUC.self) { r in
            GetGameFavorite(gameRepository: r.resolve(GameRepositoryProtocol.self)!)
        }
        container.register(AddGameFavoriteUC.self) { r in
            AddGameFavorite(gameRepository: r.resolve(GameRepositoryProtocol.self)!)
        }
        container.register(DeleteGameFavoriteUC.self) { r in
            DeleteGameFavorite(gameRepository: r.resolve(GameRepositoryProtocol.self)!)
        }
        
        // View Models
        container.register(GameViewModel.self, factory: { r in
            GameViewModel(
                getGamesUC: r.resolve(GetGamesUC.self)!,
                getDetailGameUC: r.resolve(GetDetailGameUC.self)!
            )
        })
        container.register(FavoriteViewModel.self, factory: { r in
            FavoriteViewModel(
                getGameFavoriteUC: r.resolve(GetGameFavoriteUC.self)!,
                addGameFavoriteUC: r.resolve(AddGameFavoriteUC.self)!,
                deleteGameFavoriteUC: r.resolve(DeleteGameFavoriteUC.self)!
            )
        })
        
        return container
    }()
}
