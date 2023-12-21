//
//  ApiService.swift
//  Corn
//
//  Created by Ben  Gregory on 24/11/2023.
//

import Foundation

class ApiService {
    static let shared = ApiService() // Singleton instance
    
    private init() {} // Ensure it's a singleton
    
    
    func fetchMovies(forUserId userId: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        // Check if userId is not null or empty
        guard !userId.isEmpty else {
            completion(.failure(CustomError.emptyUserId))
            return
        }
        
        
        // Retrieve the authentication token from UserDefaults
        guard let authToken = UserDefaults.standard.string(forKey: "token") else {
            // If the token is not available, return an error
            completion(.failure(CustomError.noAuthTokenAvailable))
            return
        }
        
        let apiUrl = AppConfig.backendURL + "/users/\(userId)/movies"
        
        guard let url = URL(string: apiUrl) else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        // Use URLSession or another networking library to make the actual API request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                if let data = data {
                    
                    let decoder = JSONDecoder()
                    let movies = try decoder.decode([Movie].self, from: data)
                    
                    completion(.success(movies))
                } else {
                    throw CustomError.noDataReceived
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    
    
    
    func fetchFriends(forUserId userId: String, completion: @escaping (Result<[Friend], Error>) -> Void) {
        // Retrieve the authentication token from UserDefaults
        guard let authToken = UserDefaults.standard.string(forKey: "token") else {
            // If the token is not available, return an error
            completion(.failure(CustomError.noAuthTokenAvailable))
            return
        }
        
        let apiUrl = AppConfig.backendURL + "/users/\(userId)/friends"
        
        guard let url = URL(string: apiUrl) else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        // Use URLSession or another networking library to make the actual API request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                if let data = data {
                    let decoder = JSONDecoder()
                    let friends = try decoder.decode([Friend].self, from: data)
                    
                    completion(.success(friends))
                } else {
                    throw CustomError.noDataReceived
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    
    func fetchRandomMovies(forUserId userId: String, locale: String = "en-US", completion: @escaping (Result<[Movie], Error>) -> Void) {
        // Retrieve the authentication token from UserDefaults
        guard let authToken = UserDefaults.standard.string(forKey: "token") else {
            // If the token is not available, return an error
            completion(.failure(CustomError.noAuthTokenAvailable))
            return
        }
        
        //let apiUrl = AppConfig.backendURL + "/movies/random/\(userId)"
        let apiUrl = AppConfig.backendURL + "/movies/random/\(userId)?locale=\(locale)"
        
        guard let url = URL(string: apiUrl) else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        // Use URLSession or another networking library to make the actual API request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                if let data = data {
                    let decoder = JSONDecoder()
                    let movies = try decoder.decode([Movie].self, from: data)
                    completion(.success(movies))
                } else {
                    throw CustomError.noDataReceived
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func addMovieToUser(forUserId userId: String, movie: Movie, completion: @escaping (Result<Bool, Error>) -> Void) {
        // Retrieve the authentication token from UserDefaults
        guard let authToken = UserDefaults.standard.string(forKey: "token") else {
            // If the token is not available, return an error
            completion(.failure(CustomError.noAuthTokenAvailable))
            return
        }
        
        let apiUrl = AppConfig.backendURL + "/users/\(userId)/movies"
        
        guard let url = URL(string: apiUrl) else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            // Encode the movie object as JSON and set it as the request's body
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(movie)
        } catch {
            completion(.failure(error))
            return
        }
        
        // Use URLSession or another networking library to make the actual API request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                if data != nil {
                    // You can parse the response data here if needed
                    // In this example, we assume a successful response is always true
                    completion(.success(true))
                } else {
                    throw CustomError.noDataReceived
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func removeMovieFromUser(forUserId userId: String, movie: Movie, completion: @escaping (Result<Bool, Error>) -> Void) {
        // Retrieve the authentication token from UserDefaults
        guard let authToken = UserDefaults.standard.string(forKey: "token") else {
            // If the token is not available, return an error
            completion(.failure(CustomError.noAuthTokenAvailable))
            return
        }
        
        let apiUrl = AppConfig.backendURL + "/users/\(userId)/movies"
        
        guard let url = URL(string: apiUrl) else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Encode the movie object to JSON and set it as the request body
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(movie)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Check the HTTP status code to determine the success of the deletion
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...204:
                    // Successful deletion (No Content)
                    completion(.success(true))
                default:
                    // Handle other status codes
                    let error = NSError(domain: "Invalid HTTP status code", code: httpResponse.statusCode, userInfo: nil)
                    completion(.failure(error))
                }
            } else {
                // Unexpected response format
                let error = NSError(domain: "Invalid HTTP response", code: 0, userInfo: nil)
                completion(.failure(error))
            }
        }.resume()
    }
    
    // Needed to add friends
    struct FriendUsername: Codable {
        let username: String
    }
    
    func addFriend(forUserId userId: String, friendUsername: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        // Retrieve the authentication token from UserDefaults
        guard let authToken = UserDefaults.standard.string(forKey: "token") else {
            // If the token is not available, return an error
            completion(.failure(CustomError.noAuthTokenAvailable))
            return
        }
        
        let apiUrl = AppConfig.backendURL + "/users/\(userId)/friends"
        
        guard let url = URL(string: apiUrl) else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Encode the movie object to JSON and set it as the request body
        do {
            let encoder = JSONEncoder()
            
            let friendUsername = FriendUsername(username: friendUsername)
            
            request.httpBody = try encoder.encode(friendUsername)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Check the HTTP status code to determine the success of the deletion
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 204:
                    // Successful deletion (No Content)
                    completion(.success(true))
                default:
                    // Handle other status codes
                    let error = NSError(domain: "Invalid HTTP status code", code: httpResponse.statusCode, userInfo: nil)
                    completion(.failure(error))
                }
            } else {
                // Unexpected response format
                let error = NSError(domain: "Invalid HTTP response", code: 0, userInfo: nil)
                completion(.failure(error))
            }
        }.resume()
        
        
    }
    
    // Needed to add friends
    struct FriendId: Codable {
        let friendId: String
    }
    
    
    func removeFriend(forUserId userId: String, friend:Friend, completion: @escaping (Result<Bool, Error>) -> Void) {
        // Retrieve the authentication token from UserDefaults
        guard let authToken = UserDefaults.standard.string(forKey: "token") else {
            // If the token is not available, return an error
            completion(.failure(CustomError.noAuthTokenAvailable))
            return
        }
        
        let apiUrl = AppConfig.backendURL + "/users/\(userId)/friends"
        
        guard let url = URL(string: apiUrl) else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Encode the movie object to JSON and set it as the request body
        do {
            let encoder = JSONEncoder()
            
            let friendId = FriendId(friendId: friend.id)
            
            request.httpBody = try encoder.encode(friendId)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Check the HTTP status code to determine the success of the deletion
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 204:
                    // Successful deletion (No Content)
                    completion(.success(true))
                default:
                    // Handle other status codes
                    let error = NSError(domain: "Invalid HTTP status code", code: httpResponse.statusCode, userInfo: nil)
                    completion(.failure(error))
                }
            } else {
                // Unexpected response format
                let error = NSError(domain: "Invalid HTTP response", code: 0, userInfo: nil)
                completion(.failure(error))
            }
        }.resume()
        
        
    }
    
    
    
    func setProfilePicture(profilePictureString: String, completion: @escaping (Result<Bool,Error>)->Void){
        guard let authToken = UserDefaults.standard.string(forKey: "token") else {
            // If the token is not available, return an error
            completion(.failure(CustomError.noAuthTokenAvailable))
            return
        }
        
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            // If the user Id is not found
            completion(.failure(CustomError.noUserId))
            return
        }
        
        let apiUrl = AppConfig.backendURL + "/users/\(userId)/picture"
        
        
        guard let url = URL(string: apiUrl) else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        // Needed to add friends
        struct ProfilePicture: Codable {
            let profilePicture: String
        }
        
        
        // Encode the movie object to JSON and set it as the request body
        do {
            let encoder = JSONEncoder()
            
            let profilePicture = ProfilePicture(profilePicture: profilePictureString)
            
            request.httpBody = try encoder.encode(profilePicture)
        } catch {
            completion(.failure(error))
            return
        }
        
        
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Check the HTTP status code to determine the success of the deletion
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    // Successful deletion (No Content)
                    completion(.success(true))
                default:
                    // Handle other status codes
                    let error = NSError(domain: "Invalid HTTP status code", code: httpResponse.statusCode, userInfo: nil)
                    completion(.failure(error))
                }
            } else {
                // Unexpected response format
                let error = NSError(domain: "Invalid HTTP response", code: 0, userInfo: nil)
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    func setDeviceToken(deviceToken:String, completion: @escaping (Result<Bool, Error>)->Void){
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            // If the user Id is not found
            completion(.failure(CustomError.noUserId))
            return
        }
        
        guard let authToken = UserDefaults.standard.string(forKey: "token") else {
            // If the token is not available, return an error
            completion(.failure(CustomError.noAuthTokenAvailable))
            return
        }
        
        let apiUrl = AppConfig.backendURL + "/users/\(userId)/token"
        
        guard let url = URL(string: apiUrl) else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        struct DeviceToken : Codable {
            let deviceToken: String
        }
        
        // Encode the movie object to JSON and set it as the request body
        do {
            let encoder = JSONEncoder()
            
            let deviceTokenObject = DeviceToken(deviceToken: deviceToken)
            
            request.httpBody = try encoder.encode(deviceTokenObject)
        } catch {
            completion(.failure(error))
            return
        }
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Check the HTTP status code to determine the success of the deletion
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    // Successful deletion (No Content)
                    completion(.success(true))
                default:
                    // Handle other status codes
                    let error = NSError(domain: "Invalid HTTP status code", code: httpResponse.statusCode, userInfo: nil)
                    completion(.failure(error))
                }
            } else {
                // Unexpected response format
                let error = NSError(domain: "Invalid HTTP response", code: 0, userInfo: nil)
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    // Define custom errors
    enum CustomError: Error {
        case noAuthTokenAvailable
        case invalidURL
        case noDataReceived
        case invalidUserId
        case emptyUserId
        case noUserId
    }
}
