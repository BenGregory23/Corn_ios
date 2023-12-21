//
//  User.swift
//  Corn
//
//  Created by Ben  Gregory on 22/11/2023.
//

import Foundation

// Using Identifiable so we can List items without specifying the ID
// See in FriendsList
struct Friend: Hashable, Codable, Identifiable {
    var id: String
    var email: String
    var username: String
    var movies: [Movie]?
    var profilePicture: String?
    
    // CodingKeys to map the JSON keys to Swift property names
    private enum CodingKeys: String, CodingKey {
        case email, username, profilePicture
        case id = "_id"
    }
}
