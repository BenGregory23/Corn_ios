//
//  ContentView.swift
//  Corn
//
//  Created by Ben  Gregory on 22/11/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authenticationManager: AuthenticationManager
    @State private var selection = 2
    @State private var isAuthenticated: Bool = {
        if let storedValue = UserDefaults.standard.value(forKey: "isUserConnected") as? Bool {
            
            return storedValue
        } else {
            
            return false // Set your desired default value here
        }
    }()
    @StateObject private var movieViewModel = MovieViewModel()
    
    var body: some View {
        if authenticationManager.isAuthenticated {
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
            }
        }
        else {
            StartView(isAuthenticated: $isAuthenticated)
       }
       
    
        
    }
}
    

#Preview {
    ContentView()
        .environment(ModelData())
}

