//
//  SharedMovies.swift
//  Corn
//
//  Created by Ben  Gregory on 22/11/2023.
//

import SwiftUI

struct SharedMovies: View {
    @Environment(ModelData.self) var modelData
    @EnvironmentObject var userViewModel : UserViewModel
    @State private var showSharedMovies = true
    var friend: Friend
    @State private var sharedMovies: [Movie] = []
    @State private var friendMovies: [Movie] = []

  
    
    var body: some View {
       
           
            List(sharedMovies) { movie in
                NavigationLink{
                    MovieDetail(movie: movie, shareable: true, friendId: friend.id)
                } label: {
                    MovieRow(movie: movie)
                }
               
            }
            .navigationTitle("Shared Movies")
            .onAppear {
                getSharedMovies()
            }
        
    }
    
    
    func getSharedMovies() {
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
                
                DispatchQueue.main.async{
                    self.sharedMovies = commonMovies
                }

             
            case .failure(let error):
                // Handle the error
                print("Error: \(error)")
            }
        }
    }


}

#Preview {
    SharedMovies(friend: ModelData().friends[0])
}
