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
    @State private var isFullTextShown = false
    @State var shareable = false
    @State var friendId = ""
    
    
    
    
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
                        
                        // Show truncated or full text based on the state
                        Text(movie.overview)
                            .font(.body)
                        
                        
                        
                        
                        
                        
                    
                        Image(systemName: "heart.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.red)
                            .contextMenu {
                                menuItems
                            }
                        
                        
                        
                    }
                    .padding(.horizontal)
                    
                    
                    
                    
                    
                    
                    
                }.frame(width: geometry.size.width)
            }
        }
    }
    
    var menuItems: some View {
        Group {
            
            Button(action: {}) {
                Label("Like", systemImage: "hand.thumbsup.fill")
            }
            
            
            
            Button(action: {}) {
                Label("Love", systemImage: "heart.fill")
            }
            
            
            
            Button(action: {}) {
                Label("Want to watch", systemImage: "movieclapper.fill")
            }
            
            if(shareable == true){
                Button(action: {
                    userViewModel.proposeMovie(movie: movie, forFriendId: friendId) { result in
                        switch result {
                        case .success(_):
                            print("success")
                        case .failure(let error):
                            print(error)
                        }
                    }
                }) {
                    Label("Send a notification", systemImage: "paperplane.fill")
                }
                
            }
            
        }
    }
    
}

#Preview {
    MovieDetail(movie: ModelData().movies[0])
}
