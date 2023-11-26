//
//  MovieViewModel.swift
//  Corn
//
//  Created by Ben  Gregory on 25/11/2023.
//

import Foundation

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []

    func fetchRandomMovies() {

        ApiService.shared.fetchRandomMovies(forUserId: UserDefaults.standard.string(forKey: "userId") ?? "") { result in
            var fetchedMovies: [Movie]
            switch result {
            case .success(let movies):
                // Handle the fetched movies
                fetchedMovies = movies
               
                DispatchQueue.main.async {
                    self.movies = fetchedMovies
                  
                }
            case .failure(let error):
                // Handle the error
                print("Error fetching random movies: \(error)")
            }
        }
        
       
    }

}

