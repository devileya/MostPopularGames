//
//  File.swift
//  
//
//  Created by Arif Siregar on 31/01/23.
//

import Foundation
import Combine
import Core

public protocol FavoriteRepositoryProtocol {
    func getAllFavorites(completion: @escaping(_ games: [GameModel]) -> Void)
    func getFavoriteBySlug(slug: String, completion: @escaping(_ game: GameModel) -> Void)
    func addFavorite(game: GameModel, completion: @escaping() -> Void)
    func deleteFavoriteBySlug(slug: String, completion: @escaping() -> Void)
}
