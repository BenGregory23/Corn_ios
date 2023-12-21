//
//  MovieViewModel.swift
//  Corn
//
//  Created by Ben  Gregory on 25/11/2023.
//

import Foundation

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var loading: Bool = true
    @Published var networkErrors: NetworkErrors = NetworkErrors(movies: false)

    func fetchRandomMovies() {
        DispatchQueue.main.async{
            self.networkErrors.movies = false
        }
        loading = true
        if let userId = UserDefaults.standard.string(forKey: "userId"){
            ApiService.shared.fetchRandomMovies(forUserId: userId, locale: UserDefaults.standard.string(forKey: "movieLocale") ?? "en-US") { result in
                var fetchedMovies: [Movie]
                switch result {
                case .success(let movies):
                    // Handle the fetched movies
                    fetchedMovies = movies
                   
                    DispatchQueue.main.async {
                        self.movies = fetchedMovies
                        self.loading = false
                      
                    }
                case .failure(let error):
                    // Handle the error
                    print("Error fetching random movies: \(error)")
                    DispatchQueue.main.async{
                        self.networkErrors.movies = true
                    }
                }
            }
        }else{
            print("Error fetching random movies in MovieViewModel")
        }
        
       
    }
    
    func reloadData(){
        DispatchQueue.main.async {
            self.fetchRandomMovies()
        }
    }
    
    struct NetworkErrors {
        var movies: Bool
    }

}

