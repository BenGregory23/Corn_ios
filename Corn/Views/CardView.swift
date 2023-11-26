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
    
    
    
    var body: some View {
        ZStack{
          
            GeometryReader { geometry in
                AsyncImage(url: URL(string: AppConfig.tmdbImageURL + "/" + movie.poster)) { phase in
                    switch phase {
                    case .empty:
                        // Placeholder view, you can use any view here
                        Image("movie")
                            .resizable()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            .overlay {
                                ZStack{
                                  
                                
                                    RoundedRectangle(cornerRadius: 10.0).stroke(.white, lineWidth: 1)
                                        .opacity(0.0)
                                }
                          
                            }
                            .shadow(radius: 7)
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10.0).stroke(color, lineWidth: 1)
                                    .opacity(0.0)
                            }
                            .shadow(radius: 7)
                    case .failure:
                        // Placeholder view for when the image fails to load
                        Image(systemName: "exclamationmark.triangle")
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
            print("Movie removed")
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
