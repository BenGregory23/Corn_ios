//
//  BlobView.swift
//  Corn
//
//  Created by Ben  Gregory on 14/12/2023.
//

import SwiftUI

struct BlobView: View {
    @State private var xOffset1: CGFloat = 57
    @State private var yOffset1: CGFloat = 30
    @State private var scale1: CGFloat = 1.2

    @State private var xOffset2: CGFloat = 100
    @State private var yOffset2: CGFloat = 120
    @State private var scale2: CGFloat = 1

    @State private var xOffset3: CGFloat = 0
    @State private var yOffset3: CGFloat = 70
    @State private var scale3: CGFloat = 1
    
    @State private var duration: Double = 12

    var body: some View {
        ZStack {
            // First blob
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(.blobPurple)
                //.blur(radius: 20)
                .scaleEffect(scale1)
                .offset(x: xOffset1, y: yOffset1)
                .animation(
                    Animation.easeInOut(duration: duration)
                        .repeatForever(autoreverses: true),
                    value: xOffset1
                )

            // Second blob
            Circle()
                .frame(width: 160, height: 160)
                .foregroundColor(.blobBlue)
                //.blur(radius: 15)
                .scaleEffect(scale2)
                .offset(x: xOffset2, y: yOffset2)
                .animation(
                    Animation.easeInOut(duration: duration)
                        .repeatForever(autoreverses: true),
                    value: xOffset2
                )

            // Third blob
            Circle()
                .frame(width: 180, height: 180)
                .foregroundColor(.blobPink)
                //.blur(radius: 18)
                .scaleEffect(scale3)
                .offset(x: xOffset3, y: yOffset3)
                .animation(
                    Animation.easeInOut(duration: duration)
                        .repeatForever(autoreverses: true),
                    value: xOffset3
                )
        }
        .onAppear {
            
            
            xOffset1 = CGFloat(Int.random(in: 50..<200)); yOffset1 = -100; scale1 = 1.6
            xOffset2 = -120; yOffset2 = 140; scale2 = 1.3
            xOffset3 = 150; yOffset3 = -10; scale3 = 1.4
        }.blur(radius: 60)
    }
}


#Preview {
    BlobView()
}
