//
//  StartView.swift
//  Corn
//
//  Created by Ben  Gregory on 22/11/2023.
//

import SwiftUI


struct StartView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var movieViewModel: MovieViewModel
    
    
    
    
    
    
    var body: some View {
        
        
        
        
        NavigationStack {
            ZStack{
                
                BlobView()
                VStack(spacing: 40){
                    Spacer()
                    VStack(spacing: -5){
                        Text("Corn")
                            .font(.custom("ElodyFreeRegular", size: 90))
                        
                        Text("Find your next movie!")
                            .font(.headline)
                    }
                    
                    Spacer()
                
                    
                    ViewThatFits(in: /*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/) {
                        //LottieView(name: "popcorn", loopMode: .loop, contentMode: .scaleAspectFit)
                        SmallCards()
                    }.frame(height: 220).padding(.vertical)
                    Spacer()
                    
                    VStack(){
                        NavigationLink {
                            LogInView()
                        } label: {
                            HStack {
                                Text("Get Started")
                                    .font(.system(size: 22))
                                    .foregroundColor(.black)
                                    .frame(height: 40)
                                    .padding(.leading, 15) // Add padding to align the text properly
                                    .fontWeight(.medium)
                                
                                Spacer() // This pushes the text to the left and the icon to the right
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                                    .padding(.trailing, 15) // Add padding to align the icon properly
                            }
                            .frame(width: 300, height: 50) // Set the frame for the entire HStack
                        }
                        .buttonStyle(.borderedProminent)
                        .background(Color.white) // Set background color if needed
                        .cornerRadius(50) // Apply cornerRadius to the entire NavigationLink
                        
                        
                        
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.white)
                    .buttonBorderShape(.roundedRectangle)
                    .padding(10)
                }
            }
            
            
        }
        
        
        
    }
    
    func checkUserConnected() {
        
        // Assuming you have stored a boolean value for user connection status in UserDefaults
        let userConnected = UserDefaults.standard.bool(forKey: "isUserConnected")
       
        if(userConnected){
            userViewModel.setUserInformationFromUserDefaults()
            movieViewModel.fetchRandomMovies()
            userViewModel.fetchUserFriends()
            userViewModel.fetchUserMovies()
        }
    }
    
    
}

#Preview {
    StartView()
}
