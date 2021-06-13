//
//  GoogleSignInButtonLight.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-06-11.
//

import SwiftUI
import GoogleSignIn

// Button
struct GoogleSignInButtonLight: UIViewRepresentable {
    
    // To allow us to determine color scheme of device
    @Environment(\.colorScheme) var colorScheme
    
    func makeUIView(context: Context) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.colorScheme = GIDSignInButtonColorScheme.light
        return button
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: Context) {
    }
    
}
