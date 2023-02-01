//
//  GameRepositoryProtocol.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 18/01/23.
//

import Foundation
import Combine
import Core

public protocol GameRepositoryProtocol {
    func getGames(ordering: String?, dates: String?, page: Int) -> AnyPublisher<MostPopularGamesResponse, Error>
}
