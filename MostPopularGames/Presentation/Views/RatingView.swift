//
//  RatingView.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 09/01/23.
//

import SwiftUI

struct RatingView: View {
    var rating:CGFloat = 0.0
    var maxRating = 5
    var size = 12.0
    var inactiveColor = Color.gray
    var activeColor = Color.yellow
    var showText = true
    
    var body: some View {
        HStack {
            let stars = HStack(spacing: 0) {
                ForEach(0..<maxRating, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: size, height: size)
                        .aspectRatio(contentMode: .fit)
                }
            }
            
            stars.overlay(
                GeometryReader { g in
                    let width = rating / CGFloat(maxRating) * g.size.width
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: width)
                            .foregroundColor(activeColor)
                    }
                }
                    .mask(stars)
            )
            .foregroundColor(inactiveColor)
            
            if showText {
                Text("(\(String(format: "%.2f", rating)))")
                    .font(.caption2)
                    .foregroundColor(inactiveColor)
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView()
    }
}
