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
    @State private var filterChoice: TagsEnum = TagsEnum.none
    @State private var searchValue = ""
  
    
    var body: some View {
        
        List {
            Picker("Filter", selection: $filterChoice) {
                Text("All").tag(TagsEnum.none)
                Image(systemName: "heart.fill").tag(TagsEnum.love)
                    .foregroundColor(.red)
                Image(systemName: "eyes").tag(TagsEnum.wantToWatch)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            ForEach(sharedMovies.filter { movie in
                let containsSearchValue = searchValue.isEmpty ? true : movie.title.localizedCaseInsensitiveContains(searchValue)
                
                switch filterChoice {
                case TagsEnum.none:
                    return containsSearchValue
                case TagsEnum.love:
                    return movie.tag == .love && containsSearchValue
                case TagsEnum.wantToWatch:
                    return movie.tag == .wantToWatch && containsSearchValue
            
                }
            }, id: \.uuid) { movie in
                NavigationLink {
                    MovieDetail(movie: movie)
                } label: {
                    MovieRow(movie: movie)
                }
            }
          
        }
        .searchable(text: $searchValue)
        .navigationTitle("Movies")
        .refreshable {
            userViewModel.fetchUserMovies()
        }
        .onAppear{
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
