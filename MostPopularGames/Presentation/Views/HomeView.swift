//
//  HomeView.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 09/01/23.
//

import SwiftUI
import Swinject
import SwiftUtils

struct HomeView: View {
    
    @ObservedObject private var gameVM = Container.gameContainer.resolve(GameViewModel.self)!
    @ObservedObject private var favoriteVM = Container.gameContainer.resolve(FavoriteViewModel.self)!
    
    @State var scrollOffset = CGFloat.zero
    
    var body: some View {
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
                                LazyNavigationView(DetailGameView(slug: game.slug))
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
                    .scrollIndicators(.hidden)
                
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
