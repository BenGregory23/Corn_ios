//
//  Movie.swift
//  Corn
//
//  Created by Ben  Gregory on 22/11/2023.
//

import Foundation

struct Movie: Hashable, Codable, Identifiable {
    var id: String
    var idTmdb: Int?
    var title: String
    var releaseDate: Int?
    var poster: String
    var overview: String
    var uuid: UUID = UUID()
    var tag: TagsEnum?
    
    // CodingKeys to map the JSON keys to Swift property names
    private enum CodingKeys: String, CodingKey {
        case title, overview, poster, tag
        case releaseDate = "release_date"
        case idTmdb = "id_tmdb"
        case id = "_id"
    }
}


