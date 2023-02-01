//
//  GameApiProviding.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 13/01/23.
//

import Foundation
import Combine

public protocol GameApiProtocol {
    func getGames(ordering: String?, dates: String?, page: Int) -> AnyPublisher<MostPopularGamesResponse, Error>
}
