//
//  RatingView.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 09/01/23.
//

import SwiftUI

public struct RatingView: View {
    public var rating:CGFloat = 0.0
    public var maxRating = 5
    public var size = 12.0
    public var inactiveColor = Color.gray
    public var activeColor = Color.yellow
    public var showText = true
    
    public init(rating: CGFloat, maxRating: Int, size: Float, inactiveColor: Color, activeColor: Color, showText: Bool) {
        self.rating = rating
        self.maxRating = maxRating
        self.size = size
        self.inactiveColor = inactiveColor
        self.activeColor = activeColor
        self.showText = showText
    }
    
    public var body: some View {
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

//struct RatingView_Previews: PreviewProvider {
//    static var previews: some View {
//        RatingView()
//    }
//}
