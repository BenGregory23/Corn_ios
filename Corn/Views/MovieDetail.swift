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
    @State var movieTag: TagsEnum?
    
    var body: some View {
        GeometryReader { geometry in
            
          
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
                AsyncImage(url: URL(string: AppConfig.tmdbImageURL + "/" + movie.poster)) { phase in
                    switch phase {
                    case .empty:
                        // Placeholder view, you can use any view here
                        Image("movie")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            .frame(height: geometry.size.height)
                            .overlay{
                                RoundedRectangle(cornerRadius: 10.0).stroke(.gray,lineWidth: 1)
                            }
                            .shadow(radius: 7)
                            .padding(.top, 20)
                    case .success(let image):
                        
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: geometry.size.width)
                                .edgesIgnoringSafeArea(.all)

                    case .failure:
                        // Placeholder view for when the image fails to load
                        Image(systemName: "exclamationmark.triangle")
                    @unknown default:
                        // Placeholder view for unknown state
                        Image(systemName: "questionmark.diamond")
                    }
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
                        .lineLimit(5)
                }
                .padding(.horizontal, 15)
                .frame(maxWidth: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .bottom, endPoint: .top).frame(height: 400))
               
            }.frame(minWidth: geometry.size.width, idealWidth: geometry.size.width, maxWidth: .infinity, minHeight: geometry.size.height, idealHeight: geometry.size.height, maxHeight: .infinity, alignment: .bottom)
       
                
                
                
            
        }.toolbar{
            Image(systemName: movieTag == TagsEnum.love ?  "heart.fill" : movieTag == TagsEnum.wantToWatch ? "eyes" : "heart")
                .resizable()
                .frame(width: 25, height: 22)
                .scaledToFit()
                .foregroundColor(movieTag == TagsEnum.none || movieTag == TagsEnum.love ? .red : .white)
                .contextMenu {
                    menuItems
                }.padding(.vertical)
                .onAppear{
                    DispatchQueue.main.async{
                        self.movieTag = movie.tag
                    }
                }.ignoresSafeArea()
               
        }
    }
    
    var menuItems: some View {
        Group {
            
            
            Button(action: {
                setMovieTag(tag: TagsEnum.love)
            }) {
                Label("Love", systemImage: "heart.fill")
            }
            
            
            Button(action: {
                setMovieTag(tag: TagsEnum.wantToWatch)
            }) {
                Label("Want to watch", systemImage: "eyes")
            }
            
            Button(action: {
                setMovieTag(tag: TagsEnum.none)
            }) {
                Label("Want to watch", systemImage: "")
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
                    Label("Propose this movie to your friend", systemImage: "paperplane.fill")
                }
                
            }
            
        }
    }
    
    func setMovieTag(tag: TagsEnum){
        if(self.movieTag == tag){
           
            self.movieTag = TagsEnum.none
            userViewModel.setMovieTag(movie: self.movie, tag: TagsEnum.none) { result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async{
                        self.movieTag = tag
                        userViewModel.fetchUserMovies()
                    }
                    
                case .failure(let error):
                    print(error )
                }
            }
        }
        else {
            userViewModel.setMovieTag(movie: self.movie, tag: tag) { result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async{
                        self.movieTag = tag
                        userViewModel.fetchUserMovies()
                    }
                    
                case .failure(let error):
                    print(error )
                }
            }
        }
        
    }
    
}

#Preview {
    MovieDetail(movie: ModelData().movies[0])
}
