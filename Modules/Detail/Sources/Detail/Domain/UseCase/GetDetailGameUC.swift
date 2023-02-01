//
//  GetDetailGameUC.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 19/01/23.
//

import Combine
import Core

public protocol GetDetailGameUC {
    func execute(request: GetDetailRequest, completion: @escaping (DetailGameModel) -> Void)
}

public final class GetDetailGame: GetDetailGameUC {
    private let gameRepository: DetailGameRepositoryProtocol
    
    public init(gameRepository: DetailGameRepositoryProtocol) {
        self.gameRepository = gameRepository
    }
    
    private var cancellable: AnyCancellable? = nil
    
    public func execute(request: GetDetailRequest, completion: @escaping (DetailGameModel) -> Void) {
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
                completion(self.detailGameResponseToModel(response: response))
            })
    }
    
    private func detailGameResponseToModel(response: DetailGameResponse) -> DetailGameModel {
        let platforms = response.platforms.map { $0.platform.name }.joined(separator: ", ")
        let genres = response.genres.map { $0.name }.joined(separator: ", ")
        let stores = response.stores.map { $0.store.name }.joined(separator: ", ")
        let developers = response.developers.map { $0.name }.joined(separator: ", ")
     
        return DetailGameModel(
            id: response.id,
            slug: response.slug,
            name: response.name,
            released: response.released,
            platforms: platforms,
            genres: genres,
            stores: stores,
            description: response.descriptionRaw,
            developers: developers,
            backgroundImage: response.backgroundImage ?? "",
            rating: response.rating,
            metacritic: response.metacritic,
            isFavorite: false
        )
    }
}

public struct GetDetailRequest {
    let slug: String
}
