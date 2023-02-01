//
//  FavoriteView.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 13/01/23.
//

import SwiftUI
import Swinject
import SwiftUtils
import Core
import Detail

public struct FavoriteView: View {
    
    public init() {}
    
    @ObservedObject private var favoriteVM = Core.parentAssembler.resolver.resolve(FavoriteViewModel.self)!
    
    public var body: some View {
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
        }
        .onAppear {
            favoriteVM.getAllFavorite()
        }
    }
}

//struct FavoriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteView()
//    }
//}
