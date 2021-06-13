//
//  AppleAuthenticationView.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-04.
//

import SwiftUI

struct AppleAuthenticationView: View {
    
    // Access to Apple authentication information
    @EnvironmentObject var appleAuthenticationStore: AppleAuthentication
    
    // Access to Google authentication information
    @EnvironmentObject var googleAuthenticationDelegate: GoogleAuthenticationDelegate
    
    var body: some View {

        Group {
            
            if appleAuthenticationStore.userStatus == .signedIn {

                // When user is signed in to Apple, show information from that source
                AppleUserInfoView()
                
            } else if appleAuthenticationStore.userStatus == .indeterminate {
                
                VStack {
                    Spacer()
                    ProgressView("Checking authentication status…")
                    Spacer()
                }
                
            } else {
                
                if !googleAuthenticationDelegate.signedIn {
                    
                    WelcomeMessageView()
                        .padding(10)

                    AppleSignInView()

                }
                
            }
            
        }
        .onAppear {
            
            // Automatically sign in the user when the user opens the main page and they have already authenticated
            appleAuthenticationStore.restoreSignIn()
        }
        
    }
}

struct AppleAuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AppleAuthenticationView()
    }
}
