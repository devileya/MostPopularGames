//
//  Assembler.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 31/01/23.
//

import Swinject
import Core
import Home
import Favorite
import Detail

extension Assembler {
    public static let sharedAssembler: Assembler = {
        let container = Container()
        let assembler = Assembler(
            [CoreAssembly(),
            HomeAssembly(),
            FavoriteAssembly(),
            DetailAssembly()],
            container: container
        )
        
        return assembler
    }()
}
