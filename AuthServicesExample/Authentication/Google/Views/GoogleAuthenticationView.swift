//
//  GoogleAuthenticationView.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-04.
//

import GoogleSignIn
import SwiftUI

struct GoogleAuthenticationView: View {

    // Access to Apple authentication information
    @EnvironmentObject var appleAuthenticationStore: AppleAuthentication

    // Access to Google authentication information
    @EnvironmentObject var googleAuthenticationDelegate: GoogleAuthenticationDelegate

    var body: some View {

        Group {
            
            if googleAuthenticationDelegate.signedIn {
                
                GoogleUserInfoView()
                                
            } else {
                
                if appleAuthenticationStore.userStatus == .signedOut {
                    
                    GoogleSignInView()

                }
                
            }

        }
        .onAppear {
            
            // Automatically sign in the user when the user opens the main page and they have already authenticated
            GoogleAuthenticationManager().restoreSignIn()
        }

    }
}

struct GoogleAuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleAuthenticationView()
    }
}
