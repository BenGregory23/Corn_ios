//
//  StartView.swift
//  Corn
//
//  Created by Ben  Gregory on 22/11/2023.
//

import SwiftUI


struct StartView: View {
    @Binding var isAuthenticated: Bool

    
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 40){
                VStack{
                    Text("Corn")
                        .font(.system(size: 80))
                        .bold()
                    
                    Text("Find your next movie!")
                        .font(.headline)
                    
            
                    
                    
                }
                
                ViewThatFits(in: /*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/) {
                    LottieView(name: "popcorn", loopMode: .loop, contentMode: .scaleAspectFit)
                }.frame(height: 280)
                
                
                
                VStack(spacing: 20){
                    
                    NavigationLink {
                        LogInView()
                    } label: {
                        Text("Log in")
                        
                            .frame(width: 200)
                            .font(.system(size: 22))
                            .foregroundColor(.black)
                        
                    }
                    .buttonStyle(.borderedProminent)
                    
                   
                        
                    
                    NavigationLink {
                        SignUpView()
                        
                        
                    } label: {
                        
                        
                        Text("Sign up")
                            .frame(width: 200)
                            .font(.system(size: 22))
                          
                        
                    }.buttonStyle(.bordered)
                       
                    
                }
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .buttonBorderShape(.roundedRectangle)
                .padding(10)
            }
            
            
            
            
            
            
            
        }
    }
}

#Preview {
    StartView(isAuthenticated: .constant(false))
}
