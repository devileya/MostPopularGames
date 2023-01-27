//
//  GameViewModelTests.swift
//  MostPopularGamesTests
//
//  Created by Arif Siregar on 27/01/23.
//

@testable import MostPopularGames
import XCTest
import Swinject

final class GameViewModelTests: XCTestCase {
    
    private var nextPage = 1

    func testGetGamesUC_whenSuccessfullyGetGames_thenReturnData() throws {
        let getGamesUC = Container.gameContainer.resolve(GetGamesUC.self)!
        let request = getGamesUCRequest(ordering: "-added", dates: "2022-01-01,2022-12-31", page: self.nextPage)
        getGamesUC.execute(request: request, nextPage: { page in
            self.nextPage = page
        }) { games in
            print(games)
            XCTAssertTrue(!games.isEmpty)
        }
    }

}
