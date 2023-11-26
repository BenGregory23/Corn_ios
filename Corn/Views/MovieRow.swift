//
//  MovieRow.swift
//  Corn
//
//  Created by Ben  Gregory on 23/11/2023.
//

import SwiftUI

struct MovieRow: View {
    var movie: Movie
    @State private var showingMovieDetail = false
    @Environment(ModelData.self) var modelData
    
    var body: some View {
        Button {
            showingMovieDetail.toggle()
        } label: {
            
                
                AsyncImage(url: URL(string: AppConfig.tmdbImageURL + "/" + movie.poster)) { phase in
                    switch phase {
                    case .empty:
                        HStack{
                            
                      
                            
                            // Placeholder view, you can use any view here
                            Image("Neutral")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100.0, height: 100.0)
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                .overlay{
                                    RoundedRectangle(cornerRadius: 10.0).stroke(.gray,lineWidth: 1)
                                }
                                .shadow(radius: 7)
                            
                            VStack(alignment: .leading){
                                Text(movie.title)
                                    .bold()
                                    .font(.title3)
                                    .foregroundColor(.white)
                                Text(String(movie.releaseDate ?? 0000))
                                    .foregroundColor(.white)
                                
                            }.padding()
                        }
                    case .success(let image):
                        HStack{
                            
                      
                            
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100.0, height: 100.0)
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                .overlay{
                                    RoundedRectangle(cornerRadius: 10.0).stroke(.gray,lineWidth: 1)
                                }
                                .shadow(radius: 7)
                            
                            VStack(alignment: .leading){
                                Text(movie.title)
                                    .bold()
                                    .font(.title3)
                                    .foregroundColor(.white)
                                Text(String(movie.releaseDate ?? 0000))
                                    .foregroundColor(.white)
                                
                            }.padding()
                        }
                     
                        
                    case .failure:
                        // Placeholder view, you can use any view here
                        Image("Neutral")
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100.0, height: 100.0)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            .overlay{
                                RoundedRectangle(cornerRadius: 10.0).stroke(.gray,lineWidth: 1)
                            }
                            .shadow(radius: 7)
                        
                        VStack(alignment: .leading){
                            Text(movie.title)
                                .bold()
                                .font(.title3)
                                .foregroundColor(.white)
                            Text(String(movie.releaseDate ?? 0000))
                                .foregroundColor(.white)
                            
                        }.padding()
                    @unknown default:
                        // Placeholder view, you can use any view here
                        Image("movie")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100.0, height: 100.0)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            .overlay{
                                RoundedRectangle(cornerRadius: 10.0).stroke(.gray,lineWidth: 1)
                            }
                            .shadow(radius: 7)
                        
                        VStack(alignment: .leading){
                            Text(movie.title)
                                .bold()
                                .font(.title3)
                                .foregroundColor(.white)
                            Text(String(movie.releaseDate ?? 0000))
                                .foregroundColor(.white)
                            
                        }.padding()
                    }
                    
                    
                 
                    
                
                
            }.sheet(isPresented: $showingMovieDetail) {
                MovieDetail(movie: modelData.movies[0])
            }
        }
    }
}

#Preview {
    MovieRow(movie: ModelData().movies[0])
}
