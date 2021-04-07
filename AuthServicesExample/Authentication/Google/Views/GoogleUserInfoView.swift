//
//  GoogleUserInfoView.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-04.
//

import GoogleSignIn
import SwiftUI

struct GoogleUserInfoView: View {
    
    // Access to Google Sign-in information
    @EnvironmentObject var googleAuthenticationDelegate: GoogleAuthenticationDelegate
    
    // Access to shared authentication information
    @EnvironmentObject var sharedAuthenticationStore: SharedAuthentication
    
    var body: some View {
        
        AuthenticatedView()
            .onAppear() {
                sharedAuthenticationStore.loggedInWithService = .google
                sharedAuthenticationStore.userName = GIDSignIn.sharedInstance().currentUser.profile.name
                sharedAuthenticationStore.userEmail = GIDSignIn.sharedInstance().currentUser.profile.email
            }
        
    }
}

struct GoogleUserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleUserInfoView()
    }
}
