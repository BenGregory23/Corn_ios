//
//  ProfileSummary.swift
//  Corn
//
//  Created by Ben  Gregory on 22/11/2023.
//

import SwiftUI


struct ProfileSummary: View {
    @EnvironmentObject var authenticationManager: AuthenticationManager
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var showDisconnectedAlert = false
  
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    Image("Neutral")
                        .resizable()
                        .frame(width: 50,height: 50)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    VStack(alignment: .leading){
                        Text(userViewModel.username)
                            .bold()
                            .font(.title)
                        Text(userViewModel.email)
                            .font(.subheadline)
                    }
                }
                
                GroupBox(label: Text("Information")) {
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "movieclapper.fill")
                            Text(String(userViewModel.movies.count))
                                .bold()
                                .font(.title)
                            Text("Movie(s)")
                                .font(.headline)
                                .offset(y:3)
                                
                        }.frame(minWidth: 300)
                        
                        HStack{
                            Image(systemName: "person.3.fill")
                            Text(String(userViewModel.friends.count))
                                .bold()
                                .font(.title)
                            Text("Friend(s)")
                                .font(.headline)
                                .offset(y:3)
                        }.frame(minWidth: 300)
                    }
                 
                    
                }.padding(.vertical)
                
                GroupBox(label: Text("State of Development")) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("The UI is coming together, and new features are in active development.")
                            .font(.body)
                        
                        Text("We appreciate your feedback as we work to enhance the app.")
                            .font(.body)
                        
                        Text("If you encounter any bugs or issues please report them.")
                            .font(.body)
                            .foregroundColor(.red) // Optionally, you can change the text color
                        
                        Text("Thank you for being a part of our app's development journey!")
                            .font(.body)
                    }
                    .padding()
                }
                
                
                Button("Disconnect") {
                    disconnect()
                }
                .buttonStyle(.bordered)
                .tint(.red)
                .foregroundColor(.white)
                .alert(isPresented: $showDisconnectedAlert) {
                    Alert(
                        title: Text("Disconnect"),
                        message: Text("Are you sure you want to disconnect?"),
                        primaryButton: .destructive(Text("Disconnect")) {
                            authenticationManager.setAuthenticated(false)
                        },
                        secondaryButton: .cancel()
                    )
                }
                
            }
        }
    }
    
    func disconnect(){
        UserDefaults.standard.set(false, forKey: "isUserConnected")
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        showDisconnectedAlert = true
    }
}


#Preview {
    ProfileSummary()
}
