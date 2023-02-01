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

struct MainView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            FavoriteView()
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
