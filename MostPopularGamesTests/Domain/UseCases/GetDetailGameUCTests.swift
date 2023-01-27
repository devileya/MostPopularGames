//
//  GetDetailGameUCTests.swift
//  MostPopularGamesTests
//
//  Created by Arif Siregar on 27/01/23.
//

@testable import MostPopularGames
import XCTest
import Swinject

final class GetDetailGameUCTests: XCTestCase {

    func testGetDetailGameUC_whenSuccessfully_thenReturnData() throws {
        let gameRepository = Container.gameContainer.resolve(GameRepositoryProtocol.self)!
        let data = try awaitPublisher(gameRepository.getDetailGame(slug: "high-on-life"))
        print(data)
        XCTAssertEqual(data.slug, "high-on-life")
    }

}
