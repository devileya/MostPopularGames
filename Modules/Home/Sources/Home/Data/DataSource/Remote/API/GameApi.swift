//
//  GameApi.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 13/01/23.
//

import Foundation
import Combine

struct GameApi: GameApiProtocol {
    
    let client: ApiClient
    
    func getGames(ordering: String?, dates: String?, page: Int) -> AnyPublisher<MostPopularGamesResponse, Error> {
        let queries = [URLQueryItem(name: "ordering", value: ordering), URLQueryItem(name: "dates", value: dates), URLQueryItem(name: "page", value: String(page))]
        return client.get("/api/games", queries: queries).map(\.value).eraseToAnyPublisher()
    }
    
}
