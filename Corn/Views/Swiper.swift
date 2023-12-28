//
//  Swiper.swift
//  Corn
//
//  Created by Ben  Gregory on 23/11/2023.
//

import SwiftUI

struct Swiper: View {
    
    
    
    @EnvironmentObject var movieViewModel: MovieViewModel
    @State private var hasLoadedData = false
    
    
    var body: some View {
            ZStack {
                
               
                    ForEach(movieViewModel.movies) { movie in
                        
                        CardView(movie: movie)
                    }
                    
                    SwiperEnd()
                        .zIndex(-1)
            }
            
        
    }
}

#Preview {
    Swiper()
}
