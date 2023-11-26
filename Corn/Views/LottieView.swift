//
//  LottieView.swift
//  Corn
//
//  Created by Ben  Gregory on 22/11/2023.
//

import SwiftUI
import Lottie


// Example Usage to size it effectively
// Need to wrap it in a *ViewThatFits*
/*
 ViewThatFits(in: /*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/) {
     LottieView(name: "speaker", loopMode: .loop, contentMode: .scaleAspectFit)
 }.frame(height: 200)
 */


struct LottieView: UIViewRepresentable {
    let name: String
    let loopMode: LottieLoopMode
    let contentMode: UIView.ContentMode
    let customSize: CGSize = CGSize(width: 100, height: 100)
    let animationView: LottieAnimationView
    
    init(name: String,
         loopMode: LottieLoopMode = .loop,
         animationSpeed: CGFloat = 1,
         contentMode: UIView.ContentMode = .scaleAspectFit
         ) {
        self.name = name
        self.animationView = LottieAnimationView(name: name)
        self.loopMode = loopMode
        self.contentMode = contentMode
   
        
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.frame = CGRect(origin: .zero, size: customSize)
        animationView.frame = CGRect(origin: .zero, size: customSize)
    
        animationView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
        animationView.contentMode = contentMode
        animationView.loopMode = loopMode

        // Load the animation
        animationView.play()

        view.addSubview(animationView)

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    
    }
}





