//
//  CornApp.swift
//  Corn
//
//  Created by Ben  Gregory on 22/11/2023.
//

import SwiftUI


@main
struct CornApp: App {
    @State private var modelData = ModelData()
    @StateObject private var authenticationManager = AuthenticationManager()
    @StateObject private var movieViewModel = MovieViewModel()
    @StateObject private var userViewModel = UserViewModel()
    @AppStorage("locale") private var locale = "en"
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
                .environmentObject(authenticationManager)
                .environmentObject(movieViewModel)
                .environmentObject(userViewModel)
                .environment(\.locale, .init(identifier: locale))
                .preferredColorScheme(.dark)
                .onAppear{
                    // on first load
                    loadUserConnected(fetchRandomMovies: true)
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    // on receive is for when the user closes and reopens it
                    loadUserConnected(fetchRandomMovies:  false)
                }
                
        }
    }
    
    
    func loadUserConnected(fetchRandomMovies: Bool) {
        let userConnected = UserDefaults.standard.bool(forKey: "isUserConnected")
        if(userConnected){
            print("Loading user", UserDefaults.standard.string(forKey: "userId") ?? "nothing for userId")
            userViewModel.setUserInformationFromUserDefaults()

            // Ensure setId is completed before proceeding
            DispatchQueue.main.async {
                // Now fetch movies or perform other actions that rely on setId being set
                if(fetchRandomMovies == true){
                    movieViewModel.fetchRandomMovies()
                }
                userViewModel.fetchUserFriends()
                userViewModel.fetchUserMovies()
            }
        }
    }
    
    
}
