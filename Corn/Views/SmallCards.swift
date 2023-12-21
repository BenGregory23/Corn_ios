//
//  SmallCards.swift
//  Corn
//
//  Created by Ben  Gregory on 15/12/2023.
//

import SwiftUI

struct SmallCards: View {
    @State private var rotationCard1: Double = 4
    @State private var rotationCard2: Double = 0
    @State private var rotationCard3: Double = -3
    
    @State private var offsetCard1: Double = 0
    @State private var offsetCard2: Double = 0
    @State private var offsetCard3: Double = 0
    
    @State private var offsetXSpark1: Double = 0
    @State private var offsetXSpark2: Double = 0
    @State private var offsetXSpark3: Double = 0
    
    @State private var offsetYSpark1: Double = 0
    @State private var offsetYSpark2: Double = 0
    @State private var offsetYSpark3: Double = 0
    
    
    @State private var duration: Double = 0.4
    @State private var isToggled: Bool = false
    
    var body: some View {
        ZStack{
            Image("movie")
                .resizable()
                .frame(width: 200, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                .overlay {
                    RoundedRectangle(cornerRadius: 10.0).stroke(.gray, lineWidth: 1)
                        .opacity(0.5)
                }
                .shadow(radius: 7)
                .rotationEffect(.degrees(rotationCard1))
                .offset(x: offsetCard1)
                .animation(
                    Animation.spring(duration: duration)
                    ,
                    value: rotationCard3
                )
                .animation(Animation.spring(duration: duration), value: offsetCard1)
            
            Image(systemName:"sparkles")
                .frame(width: 50, height: 50)
                .foregroundColor(.white)
                .offset(x: offsetXSpark1, y:offsetYSpark1)
                .animation(Animation.spring(duration: duration), value: offsetYSpark1)
            
            
            
            
            
            Image("bladerunner")
                .resizable()
                .frame(width: 200, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                .overlay {
                    RoundedRectangle(cornerRadius: 10.0).stroke(.gray, lineWidth: 1)
                        .opacity(0.5)
                }
                .shadow(radius: 7)
                .rotationEffect(.degrees(rotationCard2))
                .offset(x: offsetCard2)
                .animation(
                    Animation.spring(duration: duration),value: rotationCard2
                )
                .animation(Animation.spring(duration: duration), value: offsetCard2)
            
            Image(systemName:"sparkle")
                .frame(width: 50, height: 50)
                .foregroundColor(.white)
                .offset(x: offsetXSpark2, y:offsetYSpark2)
                .animation(Animation.spring(duration: duration), value: offsetYSpark2)
            
            Image(systemName:"sparkle")
                .frame(width: 55, height: 55)
                .foregroundColor(.white)
                .offset(x: offsetXSpark3, y:offsetYSpark3)
                .animation(Animation.spring(duration: duration), value: offsetYSpark3)
            
            
            Image("dune")
                .resizable()
                .frame(width: 200, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                .overlay {
                    RoundedRectangle(cornerRadius: 10.0).stroke(.gray, lineWidth: 1)
                        .opacity(0.5)
                }
                .offset(x: offsetCard3)
                .shadow(radius: 7)
                .rotationEffect(.degrees(rotationCard3))
                .animation(
                    Animation.spring(duration: duration)
                    ,
                    value: rotationCard3
                )
                .animation(Animation.spring(duration: duration), value: offsetCard3)
                .onTapGesture {
                    toggleCards()
                }
            
            
            
            
            
            
            
            
        }.onAppear{
            rotationCard1 = 12;
            rotationCard2 = 2;
            rotationCard3 = -14;
            
            offsetCard1 = 50;
            offsetCard2 = 0;
            offsetCard3 = -50;
            
            offsetXSpark1 = -30;
            offsetXSpark2 = -40;
            offsetXSpark3 = 100;
            
            offsetYSpark1 = -190;
            offsetYSpark2 = 180;
            offsetYSpark3 = 100;
            
            
        }
        
        
    }
    
    func toggleCards(){
        if(isToggled){
            rotationCard1 = 3;
            rotationCard2 = 0;
            rotationCard3 = -2;
            
            offsetCard1 = 0;
            offsetCard2 = 0;
            offsetCard3 = 0;
            
            offsetXSpark1 = 0;
            offsetXSpark2 = 0;
            offsetXSpark3 = 0;
            
            offsetYSpark1 = 0;
            offsetYSpark2 = 0;
            offsetYSpark3 = 0;
            
            isToggled.toggle()
        }
        else {
            rotationCard1 = 12;
            rotationCard2 = 2;
            rotationCard3 = -14;
            
            offsetCard1 = 50;
            offsetCard2 = 0;
            offsetCard3 = -50;
            
            offsetXSpark1 = -30;
            offsetXSpark2 = -40;
            offsetXSpark3 = 100;
            
            offsetYSpark1 = -190;
            offsetYSpark2 = 180;
            offsetYSpark3 = 100;
            
            
            isToggled.toggle()
        }
    }
}

#Preview {
    SmallCards()
}
