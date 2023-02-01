//
//  File.swift
//  
//
//  Created by Arif Siregar on 31/01/23.
//

import Combine
import Core

public struct DetailGameAPI: DetailGameApiProtocol {
    
    let client: ApiClient
    
    public init(client: ApiClient) {
        self.client = client
    }
    
    public func getDetailGame(slug: String) -> AnyPublisher<DetailGameResponse, Error> {
        return client.get("/api/games/\(slug)", queries: []).map(\.value).eraseToAnyPublisher()
    }
}
