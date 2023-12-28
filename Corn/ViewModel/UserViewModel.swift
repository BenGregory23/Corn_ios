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
    @Published var notifications: [Notification] = []
    @Published var id: String = ""
    @Published var email: String = ""
    @Published var username: String = ""
    @Published var token: String = ""
    @Published var networkErrors : NetworkErrors = NetworkErrors(moviesError: false, friendsError: false)
    
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
    
    func setToken(token: String){
        self.token = token
    }
    
    func setUserInformationFromUserDefaults() {
        if let userEmail = UserDefaults.standard.string(forKey: "userEmail"),
           let userId = UserDefaults.standard.string(forKey: "userId"),
           let username = UserDefaults.standard.string(forKey: "username"),
           let token = UserDefaults.standard.string(forKey: "token"){
          
            DispatchQueue.main.async {
                self.setId(id: userId)
                self.setEmail(email: userEmail)
                self.setUsername(username: username)
                self.setToken(token: token)
            }
           
        }
    }
    
    func fetchUserMovies() {
        DispatchQueue.main.async {
            self.networkErrors.moviesError = false
        }
      
        
        ApiService.shared.fetchMovies(forUserId: UserDefaults.standard.string(forKey: "userId") ?? "") { result in
           
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
                DispatchQueue.main.async {
                    self.networkErrors.moviesError = true
                }
              
            }
        }
    }
    
    
    func fetchUserFriends(){
        DispatchQueue.main.async {
            self.networkErrors.friendsError = false
        }
        
        ApiService.shared.fetchFriends(forUserId: UserDefaults.standard.string(forKey: "userId") ?? "") { result in
            switch result {
            case .success(let friends):
                DispatchQueue.main.async {
                    self.friends = friends
                }
                
            case .failure(let error):
                // Handle the error
                print("Error fetching movies: \(error)")
                DispatchQueue.main.async {
                    self.networkErrors.friendsError = true
                }
            }
        }
    }
    
    func addMovie(movie:Movie){
        ApiService.shared.addMovieToUser(forUserId: UserDefaults.standard.string(forKey: "userId") ?? "", movie: movie) { result in
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
        
        ApiService.shared.removeMovieFromUser(forUserId: UserDefaults.standard.string(forKey: "userId") ?? "", movie: movie) { result in
            switch result {
            case .success:
                // Handle success if needed
                DispatchQueue.main.async{
                  
                   // self.fetchUserMovies()
                }
                break
            case .failure(let error):
                // Handle the error
                print("Error removing movie: \(error)")
            }
        }
    }
    
   
    
    func addFriend(friendUsername: String, completion: @escaping (Bool) -> Void) {
        ApiService.shared.addFriend(forUserId: self.id, friendUsername: friendUsername) { result in
            switch result {
            case .success(_ ):
                DispatchQueue.main.async {
                    self.fetchUserFriends()
                    completion(true)
                }
            case .failure(let error):
                // Handle the error
                print("Error adding friend: \(error)")
                completion(false)
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
    
    
    func setProfilePicture( profilePictureString: String, completion: @escaping (Result<Bool, Error>) -> Void){
        ApiService.shared.setProfilePicture(profilePictureString: profilePictureString) { result in
            switch result {
            case .success(_):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func proposeMovie(movie: Movie, forFriendId: String, completion: @escaping (Result<Bool, Error>) -> Void){
        ApiServiceNotifications.shared.proposeMovieNotification(forFriendId: forFriendId, fromUserId: self.id, movie: movie){ result in
            switch result {
            case .success(_):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func setMovieTag(movie: Movie, tag: TagsEnum,completion: @escaping (Result<Bool, Error>)->Void){
        
        ApiService.shared.setMovieTag(movieId: movie.id, tag: tag) { result in
            switch result {
            case .success(_):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMovieTag(){
        // todo if needed later
    }
    
    
    
    
    func reloadData(){
        DispatchQueue.main.async {
            self.fetchUserFriends()
            self.fetchUserMovies()
        }
    }
    
    
    struct NetworkErrors {
        var moviesError: Bool
        var friendsError: Bool
    }
    
    
}



