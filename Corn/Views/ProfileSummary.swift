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
    @EnvironmentObject var notificationViewModel : NotificationViewModel
    @State private var showDisconnectedAlert = false
    @AppStorage("profile_picture") private var profilePicture = "char_0_3"
    
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    
                    Image("Profiles/" + profilePicture)
                        .resizable()
                        .frame(width: 60,height: 60)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.accentColor, lineWidth: 3)
                            
                        ).padding(3)
                    
                    VStack(alignment: .leading){
                        Text(userViewModel.username)
                            .bold()
                            .font(.title)
                        Text(userViewModel.email)
                            .font(.subheadline)
                    }
                }
                
                
                
                
                GroupBox{
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "movieclapper.fill")
                                .frame(minWidth: 40)
                            Text(String(userViewModel.movies.count))
                                .bold()
                                .font(.title)
                            Text("Movie(s)")
                                .font(.headline)
                                .offset(y:3)
                        }
                        
                        
                        HStack{
                            Image(systemName: "person.3.fill")
                                .frame(minWidth: 40)
                            Text(String(userViewModel.friends.count))
                                .bold()
                                .font(.title)
                            Text("Friend(s)")
                                .font(.headline)
                                .offset(y:3)
                        }
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                
               
                   
               
                List(notificationViewModel.notifications, id: \.self) { notification in
                                HStack {
                                    
                                    Image(systemName: "bell") // Add an icon if desired
                                    Text(notification.request.content.title)
                                        .foregroundStyle(.white)
                                    Spacer()
                                }
                            }
                            .navigationTitle("Notifications")
                            .onAppear{
                               
                                
                                notificationViewModel.listDeliveredNotifications()
                            }
                            
                
            
                    
                
                
                
                
                
                
            
                
                Spacer(minLength: 300)
                
                VStack(alignment: .center){
                    BuyCoffeeBtn()
                    Text("If you want to support me you can !")
                }.frame(maxWidth: .infinity)
                
                
                
                
            }
        }.padding()
    }
    
    func disconnect(){
        UserDefaults.standard.set(false, forKey: "isUserConnected")
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "username")
        showDisconnectedAlert = true
    }
}


#Preview {
    ProfileSummary()
}
