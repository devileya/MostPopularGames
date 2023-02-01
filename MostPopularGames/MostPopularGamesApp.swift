//
//  MostPopularGamesApp.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 09/01/23.
//

import SwiftUI
import Core
import Swinject

@main
struct MostPopularGamesApp: App {
    init() {
        Core.parentAssembler = Assembler.sharedAssembler
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
