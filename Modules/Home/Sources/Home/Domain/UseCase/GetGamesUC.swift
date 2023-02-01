//
//  GetGames.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 19/01/23.
//

import Foundation
import Combine

protocol GetGamesUC {
    func execute(request: getGamesUCRequest, nextPage: @escaping (Int) -> Void, completion: @escaping ([GameModel]) -> Void)
}

final class GetGames: GetGamesUC {
    private let gameRepository: GameRepositoryProtocol
    
    init(gameRepository: GameRepositoryProtocol) {
        self.gameRepository = gameRepository
    }
    
    private var cancellable: AnyCancellable? = nil
    
    func execute(request: getGamesUCRequest, nextPage: @escaping (Int) -> Void, completion: @escaping ([GameModel]) -> Void) {
        
        if (request.page == -1) {
            print("you got the last page")
            return
        }
        
        gameRepository.getAllFavorites { favoriteGames in
            DispatchQueue.main.async {
                self.cancellable = self.gameRepository.getGames(ordering: request.ordering, dates: request.dates, page: request.page)
                    .sink(receiveCompletion: { [weak self] status in
                        switch status {
                        case .failure:
                            print("failed to get API \(status)")
                        case .finished:
                            print("success get API")
                        }
                        self?.cancellable?.cancel()
                    }, receiveValue: { response in
                        nextPage(response.next != nil ? request.page+1 : -1)
                        completion(ResponseToModelMapper().gameResultToGameModel(gameResults: response.results, favoriteGames: favoriteGames))
                    })
            }
        }
        
    }
}

struct getGamesUCRequest {
    let ordering: String
    let dates: String
    let page: Int
}
