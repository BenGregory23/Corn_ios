//
//  HomeView.swift
//  Corn
//
//  Created by Ben  Gregory on 22/11/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showingProfile = false
    @State private var showingSettings = false
    @EnvironmentObject var movieViewModel: MovieViewModel
    @AppStorage("profile_picture") var profilePicture = ""
    
    @Environment(ModelData.self) var modelData
    
    
    var body: some View {
        VStack {
            HStack {
                
                Button {
                    showingSettings.toggle()
                } label: {
                    Image(systemName: "gear")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                }
                .sheet(isPresented: $showingSettings) {
                    Settings()
                }.padding(20)
                
                Spacer()
                Button {
                    showingProfile.toggle()
                } label: {
                    
                        if(profilePicture == ""){
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                        }
                        else {
                            Image("Profiles/" + profilePicture)
                                .resizable()
                                .frame(width: 30,height: 30)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.accentColor, lineWidth: 3)
                                     
                                    
                                ).padding(3)
                           
                            
                        }
                }
                .sheet(isPresented: $showingProfile) {
                    ProfileHost()
                }.padding(20)
                   
                
                
            }
            
            if(movieViewModel.networkErrors.movies){
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        
                        Text("There was an error.")
                            .bold()
                            .font(.title2)
                        Text("Check your internet connection.")
                        
                        Button("Retry") {
                            movieViewModel.reloadData()
                        }
                        Spacer()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }.background(.black)
                
                VStack{
                    
                }
               
            }
            else if(movieViewModel.loading) {
              
                
                PopcornLoader()
            }
            else {
                Swiper()
            }
            
            
            
            Spacer().frame(height: 30)
            
           
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
