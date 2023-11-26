//
//  AuthenticationManager.swift
//  Corn
//
//  Created by Ben  Gregory on 23/11/2023.
//



import SwiftUI

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated: Bool = false
    
    func setAuthenticated(_ value: Bool) {
        DispatchQueue.main.async {
            self.isAuthenticated = value
        }
    }
}

