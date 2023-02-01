//
//  GetDetailGameUC.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 19/01/23.
//

import Foundation
import Combine

protocol GetDetailGameUC {
    func execute(request: GetDetailRequest, completion: @escaping (DetailGameModel) -> Void)
}

final class GetDetailGame: GetDetailGameUC {
    private let gameRepository: GameRepositoryProtocol
    
    init(gameRepository: GameRepositoryProtocol) {
        self.gameRepository = gameRepository
    }
    
    private var cancellable: AnyCancellable? = nil
    
    func execute(request: GetDetailRequest, completion: @escaping (DetailGameModel) -> Void) {
        self.cancellable = self.gameRepository.getDetailGame(slug: request.slug)
            .sink(receiveCompletion: { [weak self] status in
                switch status {
                case .failure:
                    print("failed to get API \(status)")
                case .finished:
                    print("success get API")
                }
                self?.cancellable?.cancel()
            }, receiveValue: { response in
                completion(ResponseToModelMapper().detailGameResponseToModel(response: response))
            })
    }
}

struct GetDetailRequest {
    let slug: String
}
