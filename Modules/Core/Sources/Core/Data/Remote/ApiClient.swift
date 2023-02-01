//
//  HttpClient.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 13/01/23.
//

import Foundation
import Combine

public struct Response<T> {
    public let value: T
    public let response: URLResponse
}

public struct ApiClient {
    
    public init() {}
    
    private let apiKey = "31e2dcc75e4544dab2a2f59e5af9f83e"
    
    public func get<T: Decodable>(_ path: String, queries: [URLQueryItem]?, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.rawg.io"
        urlComponents.queryItems = [URLQueryItem(name: "key", value: apiKey)]
        
        urlComponents.path = path
        if let items = queries { urlComponents.queryItems?.append(contentsOf: items) }
        print(String(describing: urlComponents.url))
        
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: urlComponents.url!))
            .retry(3)
            .tryMap { result -> Response<T> in
                let item: T = try decoder.decode(T.self, from: result.data)
                return Response(value: item, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
