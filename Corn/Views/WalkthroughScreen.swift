//
//  WalkthroughScreen.swift
//  Corn
//
//  Created by Ben  Gregory on 27/11/2023.
//

import SwiftUI

struct WalkthroughScreen: View {
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        ZStack{
            if currentPage == 1 {
                ScreenView(image: "movieStep", title: "Swipe movies", detail: "Swipe right to add a movie to your list and swipe left to ignore it")
                    .transition(.slide)
            }

            if currentPage == 2 {
                ScreenView(image: "step2", title: "Your movies", detail: "Explore and manage your added movies in this section.")
                    .transition(.scale)
            }

            if currentPage == 3 {
                ScreenView(image: "step3", title: "Add friends", detail: "Connect with friends and share your movie preferences.")
                    .transition(.scale)
            }
          
        }.overlay(
            Button(action: {
                withAnimation(.easeInOut){
                    
                    if currentPage < totalPages {
                        
                        currentPage += 1
                    }else{
                        currentPage = 0
                        UserDefaults.standard.setValue(true, forKey: "hasDoneOnboarding")
                        
                    }
                }
            }, label:{
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(.white)
                    .clipShape(.circle)
                // Circular slider
                    .overlay(
                        ZStack{
                            Circle()
                                .stroke(.white.opacity(0.13), lineWidth: 4)
                            Circle()
                                .trim(from: 0, to: CGFloat(currentPage - 1) / CGFloat(totalPages))
                                .stroke(.white, lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                            
                        }.padding(-15)
                    )
            })
            , alignment: .bottom
        ).padding(.vertical)
    }
}

#Preview {
    WalkthroughScreen()
}

struct ScreenView: View {
    @AppStorage("currentPage") var currentPage = 1
    
    var image: String
    var title: String
    var detail: String
    
    var body: some View {
        VStack(spacing: 20){
            HStack{
                
                Text("Welcome")
                    .font(.title)
                    .fontWeight(.semibold)
                    .kerning(1.4)
                Spacer()
                
                Button(action: {
                    
                    withAnimation(.easeInOut){
                        currentPage = totalPages
                        UserDefaults.standard.setValue(true, forKey: "hasDoneOnboarding")
                    }
                    
                }, label: {
                    Text("Skip")
                })
            }.padding()
            
  
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay {
                    RoundedRectangle(cornerRadius: 10.0).stroke(.gray, lineWidth: 1)
                        .opacity(0.5)
                }
            
            
            
        
            VStack(alignment: .center){
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                Text(detail)
                    .frame(maxWidth: 300)
            }
          
            
            Spacer(minLength: 100)
        }
    }
}

var totalPages = 3
