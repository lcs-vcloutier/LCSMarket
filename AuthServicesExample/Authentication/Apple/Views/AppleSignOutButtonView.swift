//
//  AppleSignOutButtonView.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-06.
//

import SwiftUI

struct AppleSignOutButtonView: View {
    
    // Access to Apple authentication information
    @EnvironmentObject var appleAuthenticationStore: AppleAuthentication
    
    // Access to shared authentication information
    @EnvironmentObject var sharedAuthenticationStore: SharedAuthentication

    var body: some View {
        
        // Sign out
        Button(action: {
            
            // DEBUG
            #if DEBUG
            print("Signing out from Apple...")
            print("-------------------------")
            #endif

            // Mark for the app that the user is signed out of Apple
            appleAuthenticationStore.userStatus = .signedOut
            
            // Set the log in service currently in use
            sharedAuthenticationStore.loggedInWithService = .undetermined

            // Reset user information
            sharedAuthenticationStore.userName = ""
            sharedAuthenticationStore.userEmail = ""
            
            // Save to UserDefaults that user explicitly signed out in case app is backgrounded
            let defaults = UserDefaults.standard
            defaults.setValue(true, forKey: signedOutKey)
            
        }) {
            Text("Sign out with Apple")
        }
        .padding(.bottom)

    }
}

struct AppleSignOutButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AppleSignOutButtonView()
    }
}
