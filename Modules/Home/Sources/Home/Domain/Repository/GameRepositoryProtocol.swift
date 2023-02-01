//
//  GameRepositoryProtocol.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 18/01/23.
//

import Foundation
import Combine

protocol GameRepositoryProtocol {
    func getGames(ordering: String?, dates: String?, page: Int) -> AnyPublisher<MostPopularGamesResponse, Error>
    func getDetailGame(slug: String) -> AnyPublisher<DetailGameResponse, Error>
    func getAllFavorites(completion: @escaping(_ games: [GameModel]) -> Void)
    func getFavoriteBySlug(slug: String, completion: @escaping(_ game: GameModel) -> Void)
    func addFavorite(game: GameModel, completion: @escaping() -> Void)
    func deleteFavoriteBySlug(slug: String, completion: @escaping() -> Void)
}
