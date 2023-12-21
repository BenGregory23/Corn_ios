//
//  RandomLoader.swift
//  Corn
//
//  Created by Ben  Gregory on 02/12/2023.
//

import SwiftUI

struct RandomLoader: View {
    var body: some View {
        ViewThatFits(in: /*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/) {
            LottieView(name: "loading", loopMode: .loop, contentMode: .scaleAspectFit)
        }.frame(height:.infinity)

    }
}

#Preview {
    RandomLoader()
}
