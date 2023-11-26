//
//  SwiperEnd.swift
//  Corn
//
//  Created by Ben Gregory on 26/11/2023.
//

import SwiftUI

struct LottieMessage {
    var lottie: String
    var message: String
    var offsetDirection: OffsetDirection?
    var offsetX: Int?
}

enum OffsetDirection {
    case left
    case right
}

struct SwiperEnd: View {
    @EnvironmentObject var movieViewModel: MovieViewModel
    @State private var lottieMessages: [LottieMessage] = [
        LottieMessage(lottie: "popcorn", message: "Why not take a break and watch a movie?"),
        LottieMessage(lottie: "speaker", message: "You've swiped through a lot! Grab some popcorn and enjoy a movie break."),
        LottieMessage(lottie: "microphone", message: "Feeling overwhelmed? How about a movie to unwind?"),
        LottieMessage(lottie: "burger", message: "Time for a movie snack! You've earned it.", offsetDirection: .right, offsetX: 20),
        LottieMessage(lottie: "beer", message: "Cheers! Take a moment to relax and enjoy a movie with a refreshing drink."),
        LottieMessage(lottie: "popcorn_box", message: "You've swiped through a lot of options. Treat yourself to a movie and enjoy!", offsetDirection: .right, offsetX: 20)
    ]
    @State private var selectedMessageIndex: Int = Int.random(in: 0..<6)

    var body: some View {
        VStack(spacing: 10) {
            
            Group{
                ViewThatFits {
                    LottieView(name: lottieMessages[selectedMessageIndex].lottie)
                        .offset(x: CGFloat(lottieMessages[selectedMessageIndex].offsetDirection == .right ? lottieMessages[selectedMessageIndex].offsetX ?? 0 : 0))
                }.frame(height: 200)
            }.id(UUID())
         
       
            
            VStack{
                Text("You've swiped a lot of movies.")
                    .font(.headline)
                    .bold()
                Text(lottieMessages[selectedMessageIndex].message)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
           
            Button {
                // Change the selectedMessageIndex on button click
                selectedMessageIndex = Int.random(in: 0..<lottieMessages.count)
                movieViewModel.fetchRandomMovies()
            } label: {
                Text("Swipe more")
                    .frame(width: 120, height: 20)
            }
            .buttonStyle(.borderedProminent)
            .tint(.white)
            .foregroundColor(.black)
            
        }
        .onChange(of: selectedMessageIndex) { newValue, _ in
            // Do any additional logic you need when selectedMessageIndex changes
        }
        .frame(width: 300, height: 500)
        .background(.black)
        .padding()
    }
}

#Preview {
    SwiperEnd()
}
