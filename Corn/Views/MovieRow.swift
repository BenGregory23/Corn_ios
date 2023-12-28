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
                        Image(systemName: "photo")
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80.0, height: 100.0)
                            .clipShape(RoundedRectangle(cornerRadius: 8.0))
                            .overlay{
                                RoundedRectangle(cornerRadius: 9.0).stroke(.gray,lineWidth: 1)
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
                            .frame(width: 80.0, height: 100.0)
                            .clipShape(RoundedRectangle(cornerRadius: 8.0))
                            .overlay{
                                RoundedRectangle(cornerRadius: 8.0).stroke(.gray,lineWidth: 1)
                            }
                            .shadow(radius: 7)
                        
                        VStack(alignment: .leading){
                            Text(movie.title)
                                .bold()
                                .font(.title3)
                                .foregroundColor(.white)
                            HStack{
                                Text(String(movie.releaseDate ?? 0000))
                                    .foregroundColor(.white)
                               
                                Image(systemName: movie.tag == TagsEnum.love ?  "heart.fill" : movie.tag == TagsEnum.wantToWatch ? "eyes" : "square.slash")
                                    .foregroundColor(movie.tag == TagsEnum.love ? .red : movie.tag == TagsEnum.wantToWatch ?  .white : .clear)
                                
                             
                            }
                     
                            
                        }.padding()
                    }
                    
                    
                case .failure:
                    // Placeholder view, you can use any view here
                    Image("Neutral")
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80.0, height: 100.0)
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                        .overlay{
                            RoundedRectangle(cornerRadius: 8.0).stroke(.gray,lineWidth: 1)
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
