//
//  DeleteGameFavoriteUC.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 19/01/23.
//

import Foundation

public protocol DeleteGameFavoriteUC {
    func execute(slug: String, completion: @escaping () -> Void)
}

public final class DeleteGameFavorite: DeleteGameFavoriteUC {
    private let repository: FavoriteRepositoryProtocol
    
    public init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(slug: String, completion: @escaping () -> Void) {
        return repository.deleteFavoriteBySlug(slug: slug, completion: completion)
    }
}
