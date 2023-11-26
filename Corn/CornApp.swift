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

   
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
                .environmentObject(authenticationManager)
                .environmentObject(movieViewModel)
                .environmentObject(userViewModel)
                .preferredColorScheme(.dark)
        }
    }
}
