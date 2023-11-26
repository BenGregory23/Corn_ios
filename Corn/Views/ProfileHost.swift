//
//  ProfileHost.swift
//  Corn
//
//  Created by Ben  Gregory on 22/11/2023.
//

import SwiftUI


struct ProfileHost: View {
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ProfileSummary()
        }
        .padding()
    }
}


#Preview {
    ProfileHost()
}
