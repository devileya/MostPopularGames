//
//  GameApiProviding.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 13/01/23.
//

import Foundation
import Combine

protocol GameApiProtocol {
    func getGames(ordering: String?, dates: String?, page: Int) -> AnyPublisher<MostPopularGamesResponse, Error>
    func getDetailGame(slug: String) -> AnyPublisher<DetailGameResponse, Error>
}
