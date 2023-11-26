//
//  HomeView.swift
//  Corn
//
//  Created by Ben  Gregory on 22/11/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showingProfile = false
    @Environment(ModelData.self) var modelData
    
    
    var body: some View {
        VStack {
            HStack {
                
                
                Spacer()
                Button {
                    showingProfile.toggle()
                } label: {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                }
                .sheet(isPresented: $showingProfile) {
                    ProfileHost()
                }.padding(20)
                
                
            }
            
            
            Swiper()
            
            Spacer()
            
           
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
