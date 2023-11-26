//
//  ModelData.swift
//  Corn
//
//  Created by Ben  Gregory on 22/11/2023.
//

import Foundation

@Observable
class ModelData {
    static let shared = ModelData()

    var movies: [Movie] = []
    var friends: [Friend] = []
  
    var randomMovies: [Movie] = []

     init() {
        // Load initial data (if needed)
        //loadMovies()
        //loadFriends()
    }

    // MARK: - Public Methods

    
    func setMovies(_ movies: [Movie]){
        self.movies = movies
    }
    
    func setFriends(_ friends: [Friend]){
        self.friends = friends
    }

    // You can add similar methods for adding or updating movies and friends

    // MARK: - Private Methods

    private func loadMovies() {
        
        movies = load("movies.json")
    }

    private func loadFriends() {
        friends = load("friends.json")
    }
    
    

    private func load<T: Decodable>(_ filename: String) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
