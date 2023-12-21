//
//  Movies.swift
//  Corn
//
//  Created by Ben  Gregory on 22/11/2023.
//

import SwiftUI

struct Movies: View {
    @Environment(ModelData.self) var modelData
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var searchValue = ""
    
    var body: some View {
        NavigationSplitView {
            if userViewModel.movies.isEmpty {
                VStack {
                    
                
                    
                    if(userViewModel.networkErrors.moviesError){
                        Text("There was an error.")
                            .bold()
                            .font(.title2)
                        Text("Check your internet connection.")
                        
                        Button("Retry") {
                            userViewModel.reloadData()
                        }
                    }else{
                        LottieView(name: "popcorn")
                        Text("There is nothing here.")
                            .bold()
                            .font(.title2)
                        Text("Swipe some movies!")
                    }
                   
                }
                .frame(width: 300, height: 200)
                .navigationTitle("Movies")
                
            } else {
                List {
                    ForEach(userViewModel.movies.reversed().filter {
                        searchValue.isEmpty ? true : $0.title.localizedCaseInsensitiveContains(searchValue)
                    }, id: \.uuid) { movie in
                        NavigationLink {
                            MovieDetail(movie: movie)
                        } label: {
                            MovieRow(movie: movie)
                        }
                    }
                    .onDelete(perform: deleteMovie)
                }
                .searchable(text: $searchValue)
                .navigationTitle("Movies")
                .refreshable {
                    userViewModel.fetchUserMovies()
                }
                
            }
        } detail: {
            Text("Select a movie")
        }
    }
    
    func deleteMovie(at offsets: IndexSet) {
        DispatchQueue.main.async {
            for index in offsets {
                let reversedIndex = userViewModel.movies.count - 1 - index
                let movieToRemove = userViewModel.movies[reversedIndex]
                userViewModel.movies.remove(at: reversedIndex)
                userViewModel.removeMovie(movie: movieToRemove)
            }
        }
    }

    
}

#Preview {
    Movies()
}
