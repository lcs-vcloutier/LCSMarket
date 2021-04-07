//
//  GoogleSignInButton.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-04.
//

import SwiftUI
import GoogleSignIn

// Button
struct GoogleSignInButton: UIViewRepresentable {
    
    func makeUIView(context: Context) -> GIDSignInButton {
        return GIDSignInButton()
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: Context) {
    }
    
}
