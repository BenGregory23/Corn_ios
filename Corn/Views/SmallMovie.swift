//
//  SmallMovie.swift
//  Corn
//
//  Created by Ben  Gregory on 22/11/2023.
//

import SwiftUI

struct SmallMovie: View {
    @State private var showingMovieDetail = false
    @Environment(ModelData.self) var modelData
    
    
    
    var body: some View {
        Button {
                showingMovieDetail.toggle()
        } label: {
            Image("movie")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 110.0, height: 180.0)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                .overlay{
                    RoundedRectangle(cornerRadius: 10.0).stroke(.gray,lineWidth: 1)
                }
                .shadow(radius: 7)
        }.sheet(isPresented: $showingMovieDetail) {
            MovieDetail(movie: modelData.movies[0])
        }
      
        
    }
}

#Preview {
    SmallMovie()
}
