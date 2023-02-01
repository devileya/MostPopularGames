//
//  HomeView.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 09/01/23.
//

import SwiftUI
import Swinject
import SwiftUtils
import Core
import Favorite

public struct HomeView: View {
    
    private let parentContainer: Container
    @ObservedObject private var gameVM: GameViewModel
    @ObservedObject private var favoriteVM: FavoriteViewModel
    
    public init(parentContainer: Container) {
        self.parentContainer = parentContainer
        self.gameVM = parentContainer.resolve(GameViewModel.self)!
        self.favoriteVM = parentContainer.resolve(FavoriteViewModel.self)!
    }
    
    @State var scrollOffset = CGFloat.zero
    
    public var body: some View {
        NavigationView {
            if gameVM.isLoadingData && gameVM.nextPage == 1 {
                VStack(alignment:.center) {
                    CustomLoadingIndicator()
                }
            }
            else {
                ObservableScrollView(scrollOffset: $scrollOffset) { proxy in
                
                    LazyVStack(spacing:16) {
                        ForEach(Array(gameVM.games.enumerated()), id: \.offset) { (index, game) in
                            NavigationLink {
//                                LazyNavigationView(DetailGameView(slug: game.slug))
                            } label: {
                                GameListCell(game: game, addToFavorite: { game in
                                    favoriteVM.addFavorite(game: game)
                                    gameVM.games[index].isFavorite.toggle()
                                }, deleteToFavorite: { slug in
                                    favoriteVM.deleteFavoriteBySlug(slug: slug)
                                    gameVM.games[index].isFavorite.toggle()
                                }, isLiked: game.isFavorite)
                            }
                        }
                        
                        
                        if scrollOffset < 1000 {
                            ProgressView().onAppear {
                                print("pages \(self.gameVM.nextPage)")
                                self.gameVM.getMostPopularGames()
                            }
                        }
                    }
                    
                }.navigationBarTitle("Most Popular Games 2022", displayMode: .inline)
                
            }
        }
        .onAppear {
            gameVM.getMostPopularGames(page: 1)
        }
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
