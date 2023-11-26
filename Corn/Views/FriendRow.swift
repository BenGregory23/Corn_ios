//
//  UserRow.swift
//  Corn
//
//  Created by Ben  Gregory on 22/11/2023.
//

import SwiftUI

struct FriendRow: View {
    var friend: Friend
    
    
    var body: some View {
        HStack {
            Image("Neutral")
                .resizable()
                .frame(width: 50,height: 50)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            VStack(alignment: .leading) {
                Text(friend.username)
                    .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                Text(friend.email)
                    
            }
           
            
        }
     
    }
}

#Preview {
    Group{
        FriendRow(friend: ModelData().friends[0])
    }
}

