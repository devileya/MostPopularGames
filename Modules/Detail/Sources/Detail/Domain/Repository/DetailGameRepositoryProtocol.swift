//
//  File.swift
//  
//
//  Created by Arif Siregar on 31/01/23.
//

import Combine

public protocol DetailGameRepositoryProtocol {
    func getDetailGame(slug: String) -> AnyPublisher<DetailGameResponse, Error>
}
