//
//  GameViewModel.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 09/01/23.
//

import Foundation
import Core

public class GameViewModel: ObservableObject {
    
    private let getGamesUC: GetGamesUC
    
    public init(getGamesUC: GetGamesUC) {
        self.getGamesUC = getGamesUC
    }
    
    @Published var games = [GameModel]()
    @Published var isLoadingData = true
    @Published var isLiked = false
    
    var nextPage = 1
    
    
    func getMostPopularGames(page: Int = -1) {
        if page != -1 { self.nextPage = page }
        
        if page == 1 { self.games.removeAll() }
        
        self.isLoadingData = true
        
        let request = getGamesUCRequest(ordering: "-added", dates: "2022-01-01,2022-12-31", page: self.nextPage)
        getGamesUC.execute(request: request, nextPage: { page in
            self.nextPage = page
        }) { games in
            self.games.append(contentsOf: games)
            self.isLoadingData = false
        }
        
    }

}
