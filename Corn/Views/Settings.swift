//
//  Settings.swift
//  Corn
//
//  Created by Ben  Gregory on 23/11/2023.
//

import SwiftUI

struct Settings: View {
    @AppStorage("locale") private var selectedLocale: String = ""
    @AppStorage("movieLocale") private var selectedMovieLocale = ""
    @State private var showDisconnectedAlert = false
    @EnvironmentObject var authenticationManager: AuthenticationManager
    @EnvironmentObject var userViewModel : UserViewModel
    @EnvironmentObject var movieViewModel: MovieViewModel
    private var profilePictures = [
        "char00",
        "char01",
        "char02",
        "char03",
        "char04",
        "char05",
        "char06",
        "char10",
        "char11",
        "char12",
        "char13",
        "char14",
        "char15",
        "char16",
        "char20",
        "char21",
        "char22",
        "char23",
        "char24",
        "char25",
        "char26",
        "char30",
        "char31",
        "char32",
        "char33",
        "char34",
        "char35",
        "char36",
    ]
    @AppStorage("profile_picture") private var selectedProfile = "char00"
    @State private var showProfilePictureSelection = false
    
    var body: some View {
        NavigationStack {
            Form {
                
                Picker(selection: $selectedLocale, label: Text("Language")) {
                    Text("English").tag("en")
                    Text("Français").tag("fr")
                } .onChange(of: selectedLocale) { _, newLocale in
                    setLocale(language: newLocale)
                }
                
                Picker(selection: $selectedMovieLocale, label: Text("Movie Language")) {
                    Text("English").tag("en-EN")
                    Text("Français").tag("fr-FR")
                } .onChange(of: selectedMovieLocale) { _, newLocale in
                    setMovieLocale(movieLanguage: newLocale)
                }
                
                
                
                
                
                LabeledContent("Profile Picture") {
                    
                    Image("Profiles/" + selectedProfile)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)){
                                showProfilePictureSelection.toggle()
                            }
                            
                        }
                        .background(Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color.accentColor, lineWidth: 3)
                        )
                }
                
                
            }.navigationTitle("Settings")
                .scrollDisabled(true)
            Button("Disconnect") {
                disconnect()
            }
            .buttonStyle(.bordered)
            .tint(.red)
            .foregroundColor(.white)
            .alert(isPresented: $showDisconnectedAlert) {
                Alert(
                    title: Text("Disconnect"),
                    message: Text("Are you sure you want to disconnect?"),
                    primaryButton: .destructive(Text("Disconnect")) {
                        authenticationManager.setAuthenticated(false)
                    },
                    secondaryButton: .cancel()
                )
            }
            

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 10) {
                    ForEach(profilePictures, id: \.self) { pic in
                        VStack {
                            Image("Profiles/" + pic)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.3)){
                                        selectedProfile = pic
                                        self.userViewModel.setProfilePicture(profilePictureString: pic){ result in
                                            switch result {
                                            case .success(_):
                                                // show ui response
                                                print("")
                                            case .failure(let error) :
                                                print(error)
                                            }
                                        }
                                        showProfilePictureSelection = false
                                 
                                    }
                               
                                  
                                }
                        }
                        .background(selectedProfile == pic ? Color.accentColor : Color.clear)
                      
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(selectedProfile == pic ? Color.accentColor : Color.clear, lineWidth: 3)
                        )
                    }.scaleEffect(showProfilePictureSelection == true ? 1 : 0)
                }
                .padding(12)
                .animation(.spring, value: showProfilePictureSelection)
                .scaleEffect(showProfilePictureSelection == true ? 1 : 0)
                .opacity(showProfilePictureSelection == true ? 1 : 0)
                .background(showProfilePictureSelection == true ? Color.yellow.opacity(0.2) : .clear)
                .overlay(Rectangle().frame(width: nil, height: 3, alignment: .top).foregroundColor(showProfilePictureSelection == true ? .yellow :  Color.clear), alignment: .top)
            
              
                
                
            
            
          
        }
        
    }
    
    func setLocale(language: String) {
        UserDefaults.standard.setValue(language, forKey: "locale")
    }
    
    func setMovieLocale(movieLanguage: String) {
        UserDefaults.standard.setValue(movieLanguage, forKey: "movieLocale")
        movieViewModel.fetchRandomMovies()
    }
    
    func disconnect(){
        UserDefaults.standard.set(false, forKey: "isUserConnected")
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "profilePicture")
        UserDefaults.standard.removeObject(forKey: "movieLocale")
        showDisconnectedAlert = true
    }
    
    
}



#Preview {
    Settings()
}
