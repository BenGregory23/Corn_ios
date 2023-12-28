//
//  NotificationViewModel.swift
//  Corn
//
//  Created by Ben  Gregory on 22/12/2023.
//

import Foundation
import UserNotifications



class NotificationViewModel: ObservableObject {
    @Published var notifications: [UNNotification] = []

    func listDeliveredNotifications() {
        UNUserNotificationCenter.current().getDeliveredNotifications { notifications in
            DispatchQueue.main.async {
                self.notifications = notifications
            }
        }
    }
}
