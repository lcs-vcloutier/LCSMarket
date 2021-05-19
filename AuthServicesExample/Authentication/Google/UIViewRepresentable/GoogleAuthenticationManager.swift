//
//  GoogleAuthentication.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-04.
//

import SwiftUI
import GoogleSignIn

// Sign-In flow UI of the provider
struct GoogleAuthenticationManager: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<GoogleAuthenticationManager>) -> UIView {
        return UIView()
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<GoogleAuthenticationManager>) {
    }

    func signIn() {
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func signOut() {
        GIDSignIn.sharedInstance().signOut()
    }
    
    func restoreSignIn() {

        // Automatically sign in the user when the user opens the main page and they have already authenticated
        GIDSignIn.sharedInstance().restorePreviousSignIn()

    }
}
