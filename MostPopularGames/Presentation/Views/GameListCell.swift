//
//  GameListView.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 09/01/23.
//

import SwiftUI
import Kingfisher
import Swinject
import SwiftUtils

struct GameListCell: View {
    
    var game: GameModel
    let addToFavorite: (GameModel) -> Void
    let deleteToFavorite: (String) -> Void
    
    @State var isLiked = false
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .trailing) {
                Spacer()
                RatingView(
                    rating: CGFloat(game.rating),
                    size: 16,
                    inactiveColor: .white,
                    showText: false
                )
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(Rectangle().fill(.black.opacity(0.6)).cornerRadius(8).shadow(radius: 1))
                
            }.frame(width: 120)
                .frame(minHeight: 100).padding(.all, 0)
                .background(
//                    KFImage(URL(string: game.backgroundImage))
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 120, height: 100)
//                        .cornerRadius(8)
                    
                    AsyncImage(url: URL(string: game.backgroundImage), content: { image in
                        image
                            .resizable()
                            .scaledToFill()
                    }, placeholder: {
                        ProgressView().padding(.bottom, 38)
                    })
                    .frame(width: 120, height: 100)
                    .cornerRadius(8)
                    
                )
            
            VStack(alignment:.leading) {
                Text(game.name)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                
                Text("\(Date(dateString: game.released).asLongDateString())").font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, -15)
                
                
                Spacer()
                
                Text(game.platforms)
                    .font(.subheadline)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }.frame(maxHeight: 100)
            
            Spacer()
            
            HeartButtonView(isLiked: $isLiked, action: {
                if isLiked {
                    deleteToFavorite(game.slug)
                } else {
                    addToFavorite(game)
                }
            }).frame(width: 24, height: 24)
            
            
        }
        .frame(minHeight: 100, maxHeight: 120)
        .padding(8)
        .background(
            Rectangle().fill(.white).cornerRadius(8).shadow(color: .gray.opacity(0.2), radius: 4)
        )
        .padding(.horizontal, 8)
        .foregroundColor(.black)
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    
    let game = GameModel(id: 801032, slug: "high-on-life", name: "High on Life", released: "2022-12-13", platforms: "PC, Xbox Series S/X", backgroundImage: "https://media.rawg.io/media/games/2e7/2e732a02c29c84ca177855848932a5aa.jpg", rating: 4.02, isFavorite: true)
    
    
}

struct GameListCell_Previews: PreviewProvider {
    static var previews: some View {
        GameListCell(game: DeveloperPreview().game, addToFavorite: {_ in }, deleteToFavorite: {_ in })
    }
}
