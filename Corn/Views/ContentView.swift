//
//  ContentView.swift
//  Corn
//
//  Created by Ben  Gregory on 22/11/2023.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @EnvironmentObject var authenticationManager: AuthenticationManager
    @EnvironmentObject var userViewModel: UserViewModel
    @AppStorage("hasDoneOnboarding") var hasDoneOnboarding = false
    @State private var selection = 2
    @StateObject private var movieViewModel = MovieViewModel()
    
    var body: some View {
        if authenticationManager.isAuthenticated {
            
            if(hasDoneOnboarding == false){
                WalkthroughScreen()
            }
            else{
                TabView(selection: $selection) {
                    Movies()
                        .tabItem {
                            Label("Movies", systemImage: "heart.fill")
                        }
                        .tag(1)
                    HomeView()
                        .tabItem {
                            Label("Swipe", systemImage: "popcorn.fill")
                        }.tag(2)
                    
                    FriendsList()
                        .tabItem {
                            Label("Friends", systemImage: "person.3.fill")
                        }.tag(3)
                }.onAppear{
                    requestNotificationPermission();
                }
                
                
            }
            
        }
        else {
            StartView()
        }
        
        
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { granted, _ in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
            // Optionally handle the case where permission is not granted
        }
    }
    
    // Inside your AppDelegate or SwiftUI lifecycle adaptor
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
    }
    
    
}


#Preview {
    ContentView()
        .environment(ModelData())
}

