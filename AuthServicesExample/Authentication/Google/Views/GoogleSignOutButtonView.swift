//
//  GoogleSignOutButtonView.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-06.
//

import SwiftUI

struct GoogleSignOutButtonView: View {
    
    // Access to Google Sign-in information
    @EnvironmentObject var googleAuthenticationDelegate: GoogleAuthenticationDelegate
    
    // Access to shared authentication information
    @EnvironmentObject var sharedAuthenticationStore: SharedAuthentication

    var body: some View {
        
        // Sign out
        Button(action: {

            // Sign out from Google
            GoogleAuthenticationManager().signOut()
            googleAuthenticationDelegate.signedIn = false
            
            // Set the log in service currently in use
            sharedAuthenticationStore.loggedInWithService = .undetermined
            
            // Reset user information
            sharedAuthenticationStore.userName = ""
            sharedAuthenticationStore.userEmail = ""

        }) {
            Text("Sign out with Google")
        }
        .padding(.bottom)
        
    }
}

struct GoogleSignOutButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSignOutButtonView()
    }
}
