//
//  AppDelegate.swift
//  Corn
//
//  Created by Ben  Gregory on 18/12/2023.
//


import UIKit
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Perform any setup after launching
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        // Send the token string to your server
        ApiService.shared.setDeviceToken(deviceToken: tokenString) { result in
            
            switch result {
            case .success(let res) :
                print(res)
            case .failure(let error):
                print(error)
            }
        }
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Handle failure to register for remote notifications
        // ...
    }
}
