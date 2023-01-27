//
//  GameResultToGameModel.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 13/01/23.
//

final class ResponseToModelMapper {
    let noImageUrl = "https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM="
    
    func gameResultToGameModel(gameResults: [GameResult], favoriteGames: [GameModel]?) -> [GameModel] {
        gameResults.map { game in
            let platforms = game.platforms.map { $0.platform.name ?? ""}.joined(separator: ", ")
            let isFavorite = favoriteGames?.contains(where: { item in
                item.slug == game.slug
            })
            
            return GameModel(
                id: game.id,
                slug: game.slug,
                name: game.name,
                released: game.released,
                platforms: platforms,
                backgroundImage: game.backgroundImage ?? noImageUrl,
                rating: game.rating,
                isFavorite: isFavorite ?? false
            )
        }
    }
    
    func detailGameResponseToModel(response: DetailGameResponse) -> DetailGameModel {
        let platforms = response.platforms.map { $0.platform.name }.joined(separator: ", ")
        let genres = response.genres.map { $0.name }.joined(separator: ", ")
        let stores = response.stores.map { $0.store.name }.joined(separator: ", ")
        let developers = response.developers.map { $0.name }.joined(separator: ", ")
     
        return DetailGameModel(
            id: response.id,
            slug: response.slug,
            name: response.name,
            released: response.released,
            platforms: platforms,
            genres: genres,
            stores: stores,
            description: response.descriptionRaw,
            developers: developers,
            backgroundImage: response.backgroundImage ?? noImageUrl,
            rating: response.rating,
            metacritic: response.metacritic,
            isFavorite: false
        )
    }
}
