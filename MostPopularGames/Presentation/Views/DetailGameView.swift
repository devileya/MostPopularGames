//
//  DetailGameView.swift
//  MostPopularGames
//
//  Created by Arif Siregar on 09/01/23.
//

import SwiftUI
import Kingfisher
import Swinject
import SwiftUtils

struct DetailGameView: View {
    let slug: String
    
    @ObservedObject private var viewmodel = Container.gameContainer.resolve(GameViewModel.self)!
    
    @State var isLiked = false
    
    var body: some View {
        ZStack(alignment:.top) {
            if let data = viewmodel.detailGame {
                Color.clear.background(
                    KFImage(URL(string: data.backgroundImage))
                        .resizable()
                        .scaledToFill()
                        .frame(minHeight: 250, maxHeight: 400)
                        .edgesIgnoringSafeArea(.top)
                        .safeAreaInset(edge: .bottom, content: { DetailGameContentView(data: data)
                                .padding(.top, -10)
                        })
                )
                
                Text(data.name)
                    .font(.title)
                    .padding(8)
                    .foregroundColor(Color.white)
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.top, 25)
                    .multilineTextAlignment(.center)
                    .safeAreaInset(edge: .bottom) {
                        VStack {
                            Text(data.developers)
                                .font(.title3)
                                .padding(6)
                                .background(Color.white.opacity(0.6))
                            
                            Text(Date(dateString: data.released).asLongDateString())
                                .font(.subheadline)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 30)
                                .foregroundColor(Color.white)
                                .background(Color.black.opacity(0.4))
                                .cornerRadius(50)
                                .padding(.top, 20)
                        }
                    }
            } else if !viewmodel.isLoadingData {
                Text("Data Not Found").font(.title)
            }
            
            if viewmodel.isLoadingData {
                CustomLoadingIndicator()
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewmodel.getDetailGame(slug: slug)
        }
    }
}

struct DetailGameContentView: View {
    let data: DetailGameModel
    
    var body: some View {
        ScrollView {
            VStack(alignment:.leading) {
                HStack {
                    Text("Rate:")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                    RatingView(rating: data.rating, size: 18, inactiveColor: .white)
                        .fixedSize(horizontal: true, vertical: false)
                    
                    Spacer()
                    
                    Text("Metacritic:")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                    
                    if let metacritic = data.metacritic {
                        Text(String(describing: metacritic))
                            .font(.system(size: 18, weight: .semibold))
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding(2)
                            .background(metacritic >= 80 ? Color.green : metacritic >= 60 ? Color.yellow : Color.red)
                            .cornerRadius(50)
                    } else {
                        Text("--")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding(2)
                            .background(Color.gray)
                            .cornerRadius(50)
                    }
                }
                .padding()
                .background(Color.green.opacity(0.8))
                
                RowContentView(label: "Platform", value: data.platforms)
                RowContentView(label: "Genre", value: data.genres)
                RowContentView(label: "Store", value: data.stores)
                RowContentView(label: "Description", value: data.description)
                
            }
        }
        .scrollIndicators(.hidden)
    }
}

struct RowContentView: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack(alignment:.center) {
            Text(label)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
            
            Spacer()
            
            Text(value)
                .frame(width: 230, alignment: .leading)
                .padding()
                .background(Color.yellow)
                .padding(-12)
        }
        .padding()
        .background(Color.red)
        .padding(.top, -8)
        .padding(.bottom, 1)
    }
}

struct DetailGameView_Previews: PreviewProvider {
    static var previews: some View {
        DetailGameView(slug: "high-on-life")
    }
}
