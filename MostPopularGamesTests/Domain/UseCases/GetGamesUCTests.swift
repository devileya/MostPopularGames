//
//  GetGamesUCTests.swift
//  MostPopularGamesTests
//
//  Created by Arif Siregar on 26/01/23.
//

@testable import MostPopularGames
import XCTest
import Swinject

final class GetGamesUCTests: XCTestCase {
    
    func testGetGamesUC_whenSuccessfullyGetGames_thenReturnData() throws {
        let gameRepository = Container.gameContainer.resolve(GameRepositoryProtocol.self)!
        let data = try awaitPublisher(gameRepository.getGames(ordering: "-added", dates: "2022-01-01,2022-12-31", page: 1))
        print(data.results.first ?? "empty data")
        XCTAssertTrue(!data.results.isEmpty)
    }
    
}
