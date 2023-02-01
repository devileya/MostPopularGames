//
//  GetAllFavoritesUC.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 19/01/23.
//

import Foundation
import Core

public protocol GetGameFavoriteUC {
    func execute(completion: @escaping ([GameModel]) -> Void)
    func executeBySlug(slug: String, completion: @escaping (GameModel) -> Void)
}

public final class GetGameFavorite: GetGameFavoriteUC {
    private let repository: FavoriteRepositoryProtocol
    
    public init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(completion: @escaping ([GameModel]) -> Void) {
        return repository.getAllFavorites(completion: completion)
    }
    
    public func executeBySlug(slug: String, completion: @escaping (GameModel) -> Void) {
        return repository.getFavoriteBySlug(slug: slug, completion: completion)
    }
}
