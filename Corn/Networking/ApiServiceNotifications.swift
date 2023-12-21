//
//  ApiServiceNotifications.swift
//  Corn
//
//  Created by Ben  Gregory on 18/12/2023.
//

import Foundation

class ApiServiceNotifications{
    static let shared = ApiServiceNotifications() // Singleton instance
    
    private init() {} // Ensure it's a singleton
    
    func addFriendNotification(){
        // TODO
    }
    
    func proposeMovieNotification(forFriendId: String, fromUserId:String, movieName: String, completion: @escaping (Result<Bool, Error>)-> Void){
        //TODO
        
        
        guard !fromUserId.isEmpty else {
            completion(.failure(CustomError.emptyUserId))
            return
        }
        
        if(forFriendId == "" || movieName == ""){
            return
        }
        
        let apiUrl = AppConfig.backendURL + "/notifications"
        
        guard let url = URL(string: apiUrl) else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        guard let authToken = UserDefaults.standard.string(forKey: "token") else {
            // If the token is not available, return an error
            completion(.failure(CustomError.noAuthTokenAvailable))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        
        struct Notification: Codable{
            let senderId: String
            let recipientId: String
            let message: String
        }
       
        do {
            // Encode the movie object as JSON and set it as the request's body
            let encoder = JSONEncoder()
            let notification = Notification(senderId: fromUserId, recipientId: forFriendId, message: "First Notification!")
            request.httpBody = try encoder.encode(notification)
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
                    
                    completion(.success(true))
                } else {
                    throw CustomError.noDataReceived
                }
            } catch {
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
