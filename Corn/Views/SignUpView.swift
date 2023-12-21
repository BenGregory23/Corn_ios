//
//  SignUpView.swift
//  Corn
//
//  Created by Ben  Gregory on 22/11/2023.
//

import SwiftUI
import AuthenticationServices

struct SignUpView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showErrorAlert = false
    @State private var errorAlertMessage = ""
    @State private var showLogInView = false
    @State private var loading = false
    
    
    var body: some View {
        VStack{
            VStack(spacing: 15){
                
                Text("Sign Up")
                    .font(.custom("ElodyFreeRegular", size: 50))
                    .bold()
                
                ViewThatFits(in: /*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/) {
                    LottieView(name: "speaker", loopMode: .loop, contentMode: .scaleAspectFit)
                }.frame(height: 200)
            }
            
            Form {
                
                TextField("Username", text: $username)
                    .textContentType(.username)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                TextField("Email address", text: $email)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                SecureField("Password", text: $password)
                    .textContentType(.password)
                
            }
            .frame(width: 350, height: 300)
            .scrollDisabled(true)
            
            VStack(spacing: 10){
                
                Button {
                    signUp()
                } label: {
                    if(loading){
                        ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/).progressViewStyle(.circular).tint(.black)
                            .font(.system(size: 20))
                            .frame(width: 225, height: 30)
                    }
                    else{
                        Text("Sign up")
                            .font(.system(size: 20))
                            .frame(width: 225, height: 30)
                        
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .foregroundColor(.black)
                
                
                // Link to video to finish this
                // https://www.youtube.com/watch?v=O2FVDzoAB34
                /*
                     SignInWithAppleButton(.signUp, onRequest: configure, onCompletion: handle)
                     .frame(width: 250, height: 45)
                     .tint(.white)
                     .signInWithAppleButtonStyle(.white)
                 */
                
                
            }
            
            HStack {
                Text("Already have an account? ")
                NavigationLink(destination: LogInView()) {
                    Text("Log In")
                }
            }
            
        }.alert(isPresented: $showErrorAlert) {
            Alert(title: Text("Error"), message: Text(errorAlertMessage), dismissButton: .default(Text("OK")))
        }.navigationDestination(isPresented: $showLogInView){
            LogInView()
        }
        
    }
    
    private func signUp() {
        
        if(self.email == "" || self.password == "" || self.username == ""){
            self.errorAlertMessage = "Please enter the necessary informations.";
            self.showErrorAlert = true;
            return
        }
        
        self.loading = true
        
        
        guard let url = URL(string: AppConfig.backendURL + "/register") else {
            return
        }

        let body: [String: Any] = [
            "username": username,
            "email": email,
            "password": password
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            print("Error encoding JSON: \(error)")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                // Handle network error (e.g., show an alert)
                DispatchQueue.main.async {
                    showErrorAlert(message: "Network error: \(error.localizedDescription)")
                }
            } else if let httpResponse = response as? HTTPURLResponse {
                // Check the status code
                switch httpResponse.statusCode {
                case 200..<300:
                  
                    // Navigating to the logInView
                    showLogInView = true
                default:
                    // Handle other status codes (e.g., display an error message)
                    print("Signup failed, status code: \(httpResponse.statusCode)")
                    
                    // Attempt to extract error message from response data
                    if let data = data,
                       let errorMessage = String(data: data, encoding: .utf8) {
                        // Display error message in an alert
                        DispatchQueue.main.async {
                            showErrorAlert(message: errorMessage)
                        }
                    } else {
                        // Unable to extract error message, display a generic error
                        DispatchQueue.main.async {
                            showErrorAlert(message: "Signup failed with an unknown error.")
                        }
                    }
                }
            }
        }.resume()
    }

    // Function to show an alert with an error message
    private func showErrorAlert(message: String) {
        // Implement your alert presentation logic here
        // You can use SwiftUI's Alert or any other custom alert implementation
        // Example using SwiftUI's Alert:
        showErrorAlert = true
        errorAlertMessage = message
    }

    
    
    
}

#Preview {
    SignUpView()
}
