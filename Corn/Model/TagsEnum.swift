//
//  TagsEnum.swift
//  Corn
//
//  Created by Ben  Gregory on 22/12/2023.
//

import Foundation


enum TagsEnum: String, Codable {
    case love
    case wantToWatch
    case none

    enum CodingKeys: String, CodingKey {
        case love
        case wantToWatch
        case none
    }
}
