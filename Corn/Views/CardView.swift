//
//  CardView.swift
//  Corn
//
//  Created by Ben  Gregory on 23/11/2023.
//

import SwiftUI


struct CardView: View {
    var movie: Movie
    @EnvironmentObject var movieViewModel: MovieViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var offset = CGSize.zero
    @State private var color = Color.gray
    @State private var showingDetail = false
    
    @State private var isFlipped = false
    
    
    
    var body: some View {
        ZStack{
            
            GeometryReader { geometry in
                AsyncImage(url: URL(string: AppConfig.tmdbImageURL + "/" + movie.poster)) { phase in
                    switch phase {
                    case .empty:
                        
                        PopcornLoader()
                        
                    case .success(let image):
                        
                        
                        
                         image
                         .resizable()
                         .frame(width: geometry.size.width, height: geometry.size.height)
                         .clipShape(RoundedRectangle(cornerRadius: 10.0))
                         .overlay {
                         RoundedRectangle(cornerRadius: 10.0).stroke(color, lineWidth: 1)
                         .opacity(0.5)
                         }
                         .onTapGesture {
                         showingDetail.toggle()
                         
                         }
                         .shadow(radius: 7)
                         .sheet(isPresented: $showingDetail, content: {
                         MovieDetail(movie: movie)
                         })
                         
                        
                        // Card 3D rotation effect
                        // bad opacity animation
                        // we can see through the card for a brief moment
                        
                        /*
                        ZStack {
                            image
                                .resizable()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10.0).stroke(color, lineWidth: 1)
                                        .opacity(0.5)
                                }
                                .shadow(radius: 7)
                                .opacity(isFlipped ? 0 : 1) // Hide when the card is not flipped
                            
                            // Back view: MovieDetail
                               if isFlipped {
                                   MovieDetail(movie: movie)
                                       .rotation3DEffect(
                                           .degrees(180),
                                           axis: (x: 0, y: 1, z: 0)
                                       )
                                       .background(.darkGray)
                                       .clipShape(RoundedRectangle(cornerRadius: 10.0)) // Clipping mask here
                                       
                               }
                        }
                        .rotation3DEffect(
                            .degrees(isFlipped ? 180 : 0),
                            axis: (x: 0, y: 1, z: 0)
                        )
                        .onTapGesture {
                            withAnimation {
                                isFlipped.toggle()
                            }
                        }
                         */
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    case .failure:
                        // Placeholder view for when the image fails to load
                        Image(systemName: "exclamationmark.triangle").onAppear{
                            movieViewModel.fetchRandomMovies()
                        }
                        
                        
                        
                    @unknown default:
                        // Placeholder view for unknown state
                        Image(systemName: "questionmark.diamond")
                    }
                }
            }
            
            
            
            
            
            
        }
        .offset(x: offset.width, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(DragGesture()
            .onEnded{ _ in
                withAnimation{
                    swipeCard(width: offset.width)
                    changeColor(width: offset.width)
                }
            }
            .onChanged{ gesture in
                offset = gesture.translation
            })
    }
    
    func swipeCard(width: CGFloat){
        switch width {
        case -500...(-150):
       
            offset = CGSize(width: -500, height: 0)
        case 150...500:
            addMovie()
            offset = CGSize(width: 500, height: 0)
        default:
            offset = .zero
        }
    }
    
    func changeColor(width: CGFloat){
        switch width{
        case -500...(-130):
            color = .red
        case 130...500:
            color = .black
        default:
            color = .gray
        }
        
    }
    
    func addMovie(){
        
        userViewModel.addMovie(movie: self.movie)
    }
}

#Preview {
    CardView(movie: ModelData().movies[0])
}
