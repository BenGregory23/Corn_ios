//
//  AddFriendView.swift
//  Corn
//
//  Created by Ben  Gregory on 23/11/2023.
//

import SwiftUI

struct AddFriendView: View {
    @State var username = ""
    @State var isSuccess = false
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        VStack(alignment: .center){
            
            ViewThatFits(in: /*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/) {
                LottieView(name: "speaker", loopMode: .loop, contentMode: .scaleAspectFit)
            }.frame(height: 200)
            
            VStack(alignment: .leading) {
                
                Form {
                    Section(header: Text("Add Friend")){
                        HStack{
                            Image(systemName: "character.book.closed.fill")
                            TextField("Username", text: $username)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                        }
                        Text("You and your friend both have to add each other")
                            .foregroundColor(.gray)
                    }
                }.scrollDisabled(true)
            }
        }.padding(.top, 30)
        
        
        
        
        
        Button(action: {
            // self.userViewModel.addFriend(friendUsername: username)
            
            self.userViewModel.addFriend(friendUsername: username) { value in
                isSuccess = value
            }
        }){
            if(isSuccess){
                Text("Friend added")
                    .font(.title3)
                    .frame(width: 200.0, height: 35)
                    .onAppear {
                        withAnimation {
                            // Set isSuccess back to false after 2 seconds
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isSuccess = false
                            }
                        }
                    }
            }
            else {
                Text("Add")
                    .font(.title3)
                    .frame(width: 200.0, height: 35)
            }
            
            
        }
        .frame(width: 100.0)
        .buttonStyle(.borderedProminent)
        .bold()
        .tint(.green)
        .foregroundColor(.white)
        .padding(.bottom, 10)
        
        
    }
}


#Preview {
    AddFriendView()
}
