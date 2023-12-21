//
//  FriendsList.swift
//  Corn
//
//  Created by Ben  Gregory on 22/11/2023.
//

import SwiftUI

struct FriendsList: View {
    @Environment(ModelData.self) var modelData
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var showingAddFriendSheet = false
    
    var body: some View {
        NavigationView {
            
            
            if userViewModel.friends.isEmpty {
              
                VStack(spacing: 5){
                      
                    VStack{
                       
                        
                        
                        if(userViewModel.networkErrors.friendsError){
                            Text("There was an error.")
                                .bold()
                                .font(.title2)
                            Text("Check your internet connection.")
                            
                            Button("Retry") {
                                userViewModel.reloadData()
                            }
                        }else{
                            LottieView(name:"microphone")
                            Text("It's quiet here.")
                                .bold()
                                .font(.title2)
                            Text("Add some friends!")
                                .font(.subheadline)
                        }
                        
                        
                       
                    }
                       
                    }.frame(width: 300 ,height: 200)
                    .navigationTitle("Friends")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                showingAddFriendSheet.toggle()
                            } label: {
                                Image(systemName: "person.fill.badge.plus")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                            }
                            .sheet(isPresented: $showingAddFriendSheet) {
                               AddFriendView()
                            }.padding(20)
                        }
                    }
            } else {
                List(userViewModel.friends) { friend in
                    NavigationLink {
                        SharedMovies(friend: friend)
                    } label: {
                        FriendRow(friend: friend)
                    }
                }
                .navigationTitle("Friends")
                .refreshable {
                    userViewModel.fetchUserFriends()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddFriendSheet.toggle()
                        } label: {
                            Image(systemName: "person.fill.badge.plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                        }
                        .sheet(isPresented: $showingAddFriendSheet) {
                           AddFriendView()
                        }.padding(20)
                    }
                }
            }
            
            
            
            
        }
    }
}

#Preview {
    FriendsList()
}
