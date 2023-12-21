//
//  UserRow.swift
//  Corn
//
//  Created by Ben  Gregory on 22/11/2023.
//

import SwiftUI

struct FriendRow: View {
    var friend: Friend
    @EnvironmentObject var userViewModel : UserViewModel
    @State private var sharedMoviesCount = 0
    
    
    var body: some View {
        HStack(spacing: 15) {
            let profileString = friend.profilePicture ?? "default"
           
            
            Image("Profiles/\(profileString)")
                    .resizable()
                    .frame(width: 50,height: 50)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .overlay(
                        Circle()
                            .stroke(Color.accentColor, lineWidth: 3)
                            
                    )

            
      
            VStack(alignment: .leading) {
                Text(friend.username)
                    .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                    .fontWeight(.semibold)
              
                    
            }
        }
        .badge(sharedMoviesCount)
        .onAppear{getSharedMoviesCount()}
     
    }
    
    func getSharedMoviesCount() {
        var commonMovies: [Movie] = userViewModel.movies
        var friendMovies: [Movie] = []
        
        userViewModel.fetchMovieForUserId(forUserId: friend.id) { result in
            switch result {
            case .success(let moviesFetched):
                // Use the fetched movies
                friendMovies = moviesFetched

                // Find common movies
                commonMovies = commonMovies.filter { (movie: Movie) in
                    friendMovies.contains { (friendMovie: Movie) in
                        return friendMovie.idTmdb == movie.idTmdb
                    }
                }
                
               
                   
                self.sharedMoviesCount = commonMovies.count

             
            case .failure(let error):
                // Handle the error
                print("Error: \(error)")
            }
        }
    }
    
    
}



#Preview {
    Group{
        FriendRow(friend: ModelData().friends[0])
    }
}

