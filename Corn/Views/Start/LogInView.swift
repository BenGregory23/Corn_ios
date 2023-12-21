//
//  LogInView.swift
//  Corn
//
//  Created by Ben  Gregory on 22/11/2023.
//

import SwiftUI

struct LogInView: View {
    @State var emailAddress = ""
    @State var password = ""
    @State var loading = false
    @EnvironmentObject var authenticationManager: AuthenticationManager
    @EnvironmentObject var movieViewModel: MovieViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var showErrorAlert = false
    @State private var errorAlertMessage = ""
    
    
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                //BlobView()
                
                VStack{
                    VStack(spacing: 15){
                        Text("Log In")
                        //.font(.largeTitle)
                            .font(.custom("ElodyFreeRegular", size: 50))
                            .bold()
                        
                        ViewThatFits(in: /*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/) {
                            LottieView(name: "speaker", loopMode: .loop, contentMode: .scaleAspectFit)
                        }.frame(height: 200)
                    }
                    
                    
                    Form {
                        
                        
                        TextField("Email address", text: $emailAddress)
                            .textContentType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        SecureField("Password", text: $password)
                            .textContentType(.password)
                        
                    }
                    .frame(width: 350, height: 300)
                  
                    .scrollDisabled(true)
                  
                    
                    
                    
                    Button {
                      
                        logIn()
                    } label: {
                        if(loading){
                            ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/).progressViewStyle(.circular).tint(.black)
                                .font(.system(size: 20))
                                .frame(width: 225, height: 30)
                        }
                        else{
                            Text("Log In")
                                .font(.system(size: 20))
                                .frame(width: 225, height: 30)
                            
                        }
                       
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.white)
                    .foregroundColor(.black)
                    
                    
                    
                    
                    
                    HStack {
                        Text("Don't have an account? ")
                        NavigationLink(destination: SignUpView()) {
                            Text("Sign Up")
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Forgot Password")
                            .font(.system(size: 17))
                            .frame(width: 150)
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.black)
                    .foregroundColor(.white)
                    
                }.navigationDestination(isPresented: $authenticationManager.isAuthenticated){
                    ContentView()
                }
                
            }.alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Error"), message: Text(errorAlertMessage), dismissButton: .default(Text("OK")))
            }
            
        }
        
    }
    
    private func logIn() {
       
        
        if(self.emailAddress == "" || self.password == ""){
            self.errorAlertMessage = "Please enter the necessary informations.";
            self.showErrorAlert = true;
            return
        }
        
        self.loading.toggle()
        
        guard let emailEncoded = emailAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let passwordEncoded = password.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(AppConfig.backendURL)/login?email=\(emailEncoded)&password=\(passwordEncoded)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
            } else if let httpResponse = response as? HTTPURLResponse {
                // Check the status code
                switch httpResponse.statusCode {
                case 200..<300:
                    // Successful response
                    //print("Login successful, status code: \(httpResponse.statusCode)")
                    // Assuming 'data' is your JSON data
                    if let data = data {
                        do {
                            // Convert data to JSON object
                            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                            
                            // Check if the JSON object is a dictionary
                            if let jsonDictionary = jsonObject as? [String: Any] {
                                // Access the "token" field
                                if let token = jsonDictionary["token"] as? String {
                                    
                                    UserDefaults.standard.set(token, forKey: "token")
                                } else {
                                    print("Token field not found in the JSON data.")
                                }
                                
                                // Access the "user" field
                                if let user = jsonDictionary["user"] as? [String: Any] {
                                    
                                    // Access fields within the "user" dictionary
                                    if let userId = user["_id"] as? String,
                                       let userEmail = user["email"] as? String, let username = user["username"] as? String , let profilePicture = user["profilePicture"]  as? String {
                                        
                                        UserDefaults.standard.set(userEmail, forKey: "userEmail")
                                        UserDefaults.standard.set(userId, forKey: "userId")
                                        UserDefaults.standard.set(username, forKey: "username")
                                        UserDefaults.standard.set(true, forKey: "isUserConnected")
                                        UserDefaults.standard.set(profilePicture, forKey: "profile_picture");
                                        userViewModel.setId(id: userId)
                                        userViewModel.setEmail(email: userEmail)
                                        userViewModel.setUsername(username: username)
                                        movieViewModel.fetchRandomMovies()
                                        userViewModel.fetchUserFriends()
                                        userViewModel.fetchUserMovies()
                                        
                                        
                                        
                                    } else {
                                        print("User fields not found or have unexpected types.")
                                    }
                                } else {
                                    print("User field not found in the JSON data.")
                                }
                            } else {
                                print("JSON data is not a dictionary.")
                            }
                            
                        } catch {
                            print("Error converting JSON data: \(error)")
                        }
                    }
                    // Ensure UI updates are on the main thread
                    DispatchQueue.main.async {
                        authenticationManager.isAuthenticated = true
                    }
                default:
                    // Handle other status codes (e.g., display an error message)
                    print("Login failed, status code: \(httpResponse.statusCode)")
                    
                    // Ensure UI updates are on the main thread
                    DispatchQueue.main.async {
                        showErrorAlert(message: "An error has occurred. Please ensure that all fields have been filled correctly.")
                    }
                }
            }
        }.resume()
    }
    
    
    
    private func showErrorAlert(message: String) {
        errorAlertMessage = message
        showErrorAlert = true
    }
    
}

#Preview {
    LogInView()
}
