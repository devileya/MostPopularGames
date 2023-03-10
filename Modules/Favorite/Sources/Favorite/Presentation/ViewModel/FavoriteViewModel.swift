//
//  FavoriteViewModel.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 14/01/23.
//

import Foundation
import Core

public class FavoriteViewModel: ObservableObject {
    
    private let getGameFavoriteUC: GetGameFavoriteUC
    private let addGameFavoriteUC: AddGameFavoriteUC
    private let deleteGameFavoriteUC: DeleteGameFavoriteUC
    
    public init(getGameFavoriteUC: GetGameFavoriteUC, addGameFavoriteUC: AddGameFavoriteUC, deleteGameFavoriteUC: DeleteGameFavoriteUC) {
        self.getGameFavoriteUC = getGameFavoriteUC
        self.addGameFavoriteUC = addGameFavoriteUC
        self.deleteGameFavoriteUC = deleteGameFavoriteUC
    }
    
    @Published var favoriteGames = [GameModel]()
    
    public func addFavorite(game: GameModel) {
        addGameFavoriteUC.execute(game: game) {
            DispatchQueue.main.async {
                print("success add favorite")
                print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
            }
        }
    }
    
    public func deleteFavoriteBySlug(slug: String) {
        deleteGameFavoriteUC.execute(slug: slug) {
            DispatchQueue.main.async {
                print("success delete favorite")
                self.getAllFavorite()
            }
        }
    }
    
    public func getAllFavorite() {
        getGameFavoriteUC.execute { games in
            DispatchQueue.main.async {
                self.favoriteGames = games
            }
        }
    }
}
