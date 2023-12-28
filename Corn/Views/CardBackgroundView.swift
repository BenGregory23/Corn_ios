//
//  CardBackgroundView.swift
//  Corn
//
//  Created by Ben  Gregory on 26/12/2023.
//

import SwiftUI

struct CardBackgroundView: View {
    @EnvironmentObject private var movieViewModel: MovieViewModel
    
    
    var body: some View {
        GeometryReader { geometry in
            AsyncImage(url: URL(string: AppConfig.tmdbImageURL + "/" + (movieViewModel.movies.last?.poster ?? ""))) { phase in
                switch phase {
                case .empty:
                    Image("movie")
                        .resizable()
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: geometry.size.width)
                        .edgesIgnoringSafeArea(.all)
                        .blur(radius:12)
                        .opacity(0.7)
                case .success(let image):
                    
                    image
                        .resizable()
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: geometry.size.width)
                        .edgesIgnoringSafeArea(.all)
                        .blur(radius:12)
                        .opacity(0.7)
                        
                  
                    
                case .failure:
                    // Placeholder view for when the image fails to load
                    Image(systemName: "")
                    
                    
                @unknown default:
                    // Placeholder view for unknown state
                    Image(systemName: "questionmark.diamond")
                }
            }
        }
        
    }
}
