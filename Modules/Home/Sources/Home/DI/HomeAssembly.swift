//
//  HomeAssembly.swift
//  
//
//  Created by Arif Siregar on 31/01/23.
//

import Swinject

//public class HomeAssembly: Assembly {
//    
//    public init(){}
//    
//    public func assemble(container: Container) {
//        // Data Source
//        container.register(GameApiProtocol.self, factory: {r in
//            GameApi(client: r.resolve(ApiClient.self)!)
//        })
//        
//        // Repositories
//        container.register(GameRepositoryProtocol.self) { r in
//            GameRepository(gameApi: r.resolve(GameApiProtocol.self)!, favoriteDB: r.resolve(FavoriteGameProvider.self)!)
//        }
//        
//        // Use Cases
//        container.register(GetGamesUC.self) { r in
//            GetGames(gameRepository: r.resolve(GameRepositoryProtocol.self)!)
//        }
//        
//        // View Models
//        container.register(GameViewModel.self, factory: { r in
//            GameViewModel(getGamesUC: r.resolve(GetGamesUC.self)!)
//        })
//    }
//}
