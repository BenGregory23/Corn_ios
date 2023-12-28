//
//  Notification.swift
//  Corn
//
//  Created by Ben  Gregory on 22/12/2023.
//

import Foundation

struct Notification : Hashable, Codable, Identifiable {
    var id: String
    var notificationType: NotificationType
    var title: String
    var subtitle: String?
    var message : String
}

enum NotificationType : Codable {
    case friendRequest
    case movieRequest
}
