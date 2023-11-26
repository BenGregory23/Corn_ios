import SwiftUI
import AuthenticationServices


struct SignInWithApple: UIViewRepresentable {
  
  func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
    
    return ASAuthorizationAppleIDButton()
  }
  
  
  func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
  }
}
