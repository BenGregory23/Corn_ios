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
    @State private var filterChoice: TagsEnum = TagsEnum.none
    
    var body: some View {
            NavigationSplitView {
                if userViewModel.movies.isEmpty {
                    // ... (Your empty state view)
                } else {
                    List {
                        Picker("Filter", selection: $filterChoice) {
                            Text("All").tag(TagsEnum.none)
                            Image(systemName: "heart.fill").tag(TagsEnum.love)
                                .foregroundColor(.red)
                            Image(systemName: "eyes").tag(TagsEnum.wantToWatch)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        ForEach(userViewModel.movies.reversed().filter { movie in
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
