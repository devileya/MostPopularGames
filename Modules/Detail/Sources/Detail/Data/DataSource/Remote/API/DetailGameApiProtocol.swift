//
//  File.swift
//  
//
//  Created by Arif Siregar on 31/01/23.
//

import Combine

protocol DetailGameApiProtocol {
    func getDetailGame(slug: String) -> AnyPublisher<DetailGameResponse, Error>
}
