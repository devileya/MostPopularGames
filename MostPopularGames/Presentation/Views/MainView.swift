//
//  ContentView.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 09/01/23.
//

import SwiftUI
import Home
import Favorite
import Profile
import Swinject
import Core

struct MainView: View {
    
    init() {
        Core.parentContainer = Container.gameContainer
    }
    
    var body: some View {
        TabView {
            HomeView(parentContainer: Container.gameContainer)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            FavoriteView(parentContainer: Container.gameContainer)
                .tabItem {
                    Label("Favorite", systemImage: "heart")
                }
            
            AboutMeView()
                .tabItem {
                    Label("About Me", systemImage: "person")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
