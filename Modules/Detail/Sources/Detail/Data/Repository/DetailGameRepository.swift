//
//  File.swift
//  
//
//  Created by Arif Siregar on 31/01/23.
//

import Combine

public final class DetailGameRepository: DetailGameRepositoryProtocol {
    private let gameApi: DetailGameApiProtocol
    
    public init(gameApi: DetailGameApiProtocol) {
        self.gameApi = gameApi
    }
    
    public func getDetailGame(slug: String) -> AnyPublisher<DetailGameResponse, Error> {
        return gameApi.getDetailGame(slug: slug)
    }
}
