//
//  FavoriteAssembly.swift
//  
//
//  Created by Arif Siregar on 01/02/23.
//

import Swinject
import Core

public class FavoriteAssembly: Assembly {
    
    public init(){}
    
    public func assemble(container: Container) {
        // Repositories
        container.register(FavoriteRepositoryProtocol.self) { r in
            FavoriteRepository(favoriteDB: r.resolve(FavoriteGameProvider.self)!)
        }
        
        // Use Cases
        container.register(GetGameFavoriteUC.self) { r in
            GetGameFavorite(repository: r.resolve(FavoriteRepositoryProtocol.self)!)
        }
        container.register(AddGameFavoriteUC.self) { r in
            AddGameFavorite(repository: r.resolve(FavoriteRepositoryProtocol.self)!)
        }
        container.register(DeleteGameFavoriteUC.self) { r in
            DeleteGameFavorite(repository: r.resolve(FavoriteRepositoryProtocol.self)!)
        }
        
        // View Models
        container.register(FavoriteViewModel.self, factory: { r in
            FavoriteViewModel(
                getGameFavoriteUC: r.resolve(GetGameFavoriteUC.self)!,
                addGameFavoriteUC: r.resolve(AddGameFavoriteUC.self)!,
                deleteGameFavoriteUC: r.resolve(DeleteGameFavoriteUC.self)!
            )
        })
    }
}
