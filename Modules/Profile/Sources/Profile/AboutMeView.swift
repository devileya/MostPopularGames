//
//  ProfileView.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 09/01/23.
//

import SwiftUI

public struct AboutMeView: View {
    
    public init() {}
    
    public var body: some View {
        VStack {
            Text("About Me").font(.title)
                .padding(.bottom, 36)
            
            Image("photo")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
            
            Text("Arif Fadly Siregar").font(.title2)
            Text("fadlyarif77@gmail.com").font(.title3).foregroundColor(.gray)
            
            Spacer()
            
            if #available(iOS 16.0, *) {
                Text("\"This Project Was Created By Me On \n 11 January 2022\"")
                    .multilineTextAlignment(.center)
                    .italic()
            } else {
                Text("\"This Project Was Created By Me On \n 11 January 2022\"")
            }
            
            Spacer()
        }
    }
}

struct AboutMeView_Previews: PreviewProvider {
    static var previews: some View {
        AboutMeView()
    }
}
