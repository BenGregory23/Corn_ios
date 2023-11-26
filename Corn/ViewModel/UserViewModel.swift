//
//  UserViewModel.swift
//  Corn
//
//  Created by Ben  Gregory on 25/11/2023.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var friends: [Friend] = []
    @Published var id: String = ""
    @Published var email: String = ""
    @Published var username: String = ""
    
    func setId(id: String){
        DispatchQueue.main.async {
            self.id = id
        }
        
    }
    
    func setEmail(email: String){
        DispatchQueue.main.async {
            self.email = email
        }
 
    }
    
    func setUsername(username: String){
        DispatchQueue.main.async {
            self.username = username
        }
       
    }
    
    func fetchUserMovies() {
    
        ApiService.shared.fetchMovies(forUserId: self.id) { result in
            
            // Check if self.id is not null or empty
            if !self.id.isEmpty {
                if let storedUserId = UserDefaults.standard.string(forKey: "userId"), !storedUserId.isEmpty {
                    // Use the user ID from UserDefaults
                    DispatchQueue.main.async {
                        self.id = storedUserId
                    }
                    
                } else {
                    print("Error: User ID is empty.")
                    return
                }
            }
            
            
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
                print("Error fetching user movies: \(error)")
            }
        }
    }
    
    
    func fetchUserFriends(){
        ApiService.shared.fetchFriends(forUserId: self.id) { result in
            switch result {
            case .success(let friends):
                DispatchQueue.main.async {
                    self.friends = friends
                }
                
            case .failure(let error):
                // Handle the error
                print("Error fetching movies: \(error)")
            }
        }
    }
    
    func addMovie(movie:Movie){
        ApiService.shared.addMovieToUser(forUserId: self.id, movie: movie) { result in
            switch result {
            case .success(_ ):
                DispatchQueue.main.async {
                    self.fetchUserMovies()
                }
            case .failure(let error):
                // Handle the error
                print("Error fetching movies: \(error)")
            }
        }
    }
    
    func removeMovie(movie: Movie) {
        movies.removeAll { $0.id == movie.id }

        ApiService.shared.removeMovieFromUser(forUserId: self.id, movie: movie) { result in
            switch result {
            case .success:
                // Handle success if needed
                DispatchQueue.main.async{
                    print("success")
                    self.fetchUserMovies()
                }
                break
            case .failure(let error):
                // Handle the error
                print("Error removing movie: \(error)")
            }
        }
    }

    
    func addFriend(friendUsername: String){
        ApiService.shared.addFriend(forUserId: self.id, friendUsername: friendUsername) { result in
            switch result {
            case .success(_ ):
                DispatchQueue.main.async {
                                    self.fetchUserMovies()
                }
            case .failure(let error):
                // Handle the error
                print("Error adding friend: \(error)")
            }
        }
        
    }
    
    func removeFriend(friend:Friend){
        ApiService.shared.removeFriend(forUserId: self.id, friend: friend) { result in
            switch result {
            case .success(_ ):
                DispatchQueue.main.async {
                    self.fetchUserFriends()
                }
            case .failure(let error):
                // Handle the error
                print("Error adding friend: \(error)")
            }
        }
    }
    
    
    func fetchMovieForUserId(forUserId userId: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        ApiService.shared.fetchMovies(forUserId: userId) { result in
            switch result {
            case .success(let movies):
                // Handle the fetched movies
                completion(.success(movies))
            case .failure(let error):
                // Handle the error
                print("Error fetching user movies: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    
}



