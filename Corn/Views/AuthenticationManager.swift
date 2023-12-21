//
//  AuthenticationManager.swift
//  Corn
//
//  Created by Ben  Gregory on 23/11/2023.
//



import SwiftUI

class AuthenticationManager: ObservableObject {
    @AppStorage("isUserConnected") var isAuthenticated: Bool = false

    // You can keep the setAuthenticated method if you need additional logic
    func setAuthenticated(_ value: Bool) {
        isAuthenticated = value
    }
}
