//
//  BuyCoffeeBtn.swift
//  Corn
//
//  Created by Ben  Gregory on 11/12/2023.
//

import SwiftUI

struct BuyCoffeeBtn: View {
    let yellowBuyCoffee = Color(red: 249, green: 222, blue: 74)
    var body: some View {
        
        
        
        Link(destination: URL(string: "https://www.buymeacoffee.com/tnyggdjhjxo")!) {
            
            HStack{
                
                Image("buy-coffee-white")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 37, height: 37)
                Text("Buy me a Coffee")
                    .bold()
                    .font(.title3)
                    .padding(.trailing, 4)
                
            }.padding(2)
            
        }.padding(5)
            .background(.yellowCoffee)
            .tint(.black)
            .cornerRadius(20)
        
    }
    
}

#Preview {
    BuyCoffeeBtn()
}
