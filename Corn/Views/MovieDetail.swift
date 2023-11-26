//
//  MovieDetail.swift
//  Corn
//
//  Created by Ben  Gregory on 23/11/2023.
//

import SwiftUI


struct MovieDetail: View {
    var movie:Movie
    @EnvironmentObject var userViewModel: UserViewModel
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                
             
                    AsyncImage(url: URL(string: AppConfig.tmdbImageURL + "/" + movie.poster)) { phase in
                        switch phase {
                        case .empty:
                            // Placeholder view, you can use any view here
                            Image("movie")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                .frame(height: geometry.size.height * 0.5)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 10.0).stroke(.gray,lineWidth: 1)
                                }
                                .shadow(radius: 7)
                                .padding(.top, 20)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                .frame(height: geometry.size.height * 0.5)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 10.0).stroke(.gray,lineWidth: 1)
                                }
                                .shadow(radius: 7)
                                .padding(.top, 20)
                        case .failure:
                            // Placeholder view for when the image fails to load
                            Image(systemName: "exclamationmark.triangle")
                        @unknown default:
                            // Placeholder view for unknown state
                            Image(systemName: "questionmark.diamond")
                        }
                    
                  
                    
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text(movie.title)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                        
                        
                        Text(String(movie.releaseDate ?? 0000))
                            .bold()
                        
                        Text(movie.overview)
                            .font(.body)
                        
                        ShareLink(item: /*@START_MENU_TOKEN@*/URL(string: "https://developer.apple.com/xcode/swiftui")!/*@END_MENU_TOKEN@*/)
                            .padding(.vertical)
                        
                        
                        
                        
                    }
                    .padding(.horizontal)
                    
                  
                    
                }.frame(width: geometry.size.width)
            }
        }
        
        
    }
}

#Preview {
    MovieDetail(movie: ModelData().movies[0])
}
