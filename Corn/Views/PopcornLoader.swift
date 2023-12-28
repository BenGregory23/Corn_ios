//
//  PopcornLoader.swift
//  Corn
//
//  Created by Ben  Gregory on 04/12/2023.
//

import SwiftUI

import SwiftUI

struct PopcornLoader: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                Image(systemName: "popcorn.fill")
                    .symbolEffect(.pulse)
                    .font(.system(size: 30))
                    .frame(maxHeight: .infinity)
                Spacer()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }.background(.clear)
    }
}




#Preview {
    PopcornLoader()
}
