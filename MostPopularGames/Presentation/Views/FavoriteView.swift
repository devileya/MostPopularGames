//
//  FavoriteView.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 13/01/23.
//

import SwiftUI
import Swinject
import SwiftUtils

struct FavoriteView: View {
    
    @ObservedObject private var favoriteVM = Container.gameContainer.resolve(FavoriteViewModel.self)!
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing:16) {
                    ForEach(favoriteVM.favoriteGames) { game in
                        NavigationLink {
                            LazyNavigationView(DetailGameView(slug: game.slug))
                        } label: {
                            GameListCell(game: game, addToFavorite: { game in
                                favoriteVM.addFavorite(game: game)
                            }, deleteToFavorite: { slug in
                                favoriteVM.deleteFavoriteBySlug(slug: slug)
                            }, isLiked: game.isFavorite)
                        }
                    }
                }
            }.navigationBarTitle("My Favorite Games", displayMode: .inline)
                .scrollIndicators(.hidden)
        }
        .onAppear {
            favoriteVM.getAllFavorite()
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
