//
//  SignOutButtonView.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-06.
//

import SwiftUI

struct SignOutButtonView: View {
    
    // Access to shared authentication information
    @EnvironmentObject var sharedAuthenticationStore: SharedAuthentication

    var body: some View {
        
        if sharedAuthenticationStore.loggedInWithService == .apple {
            
            AppleSignOutButtonView()
            
        } else if sharedAuthenticationStore.loggedInWithService == .google {
            
            GoogleSignOutButtonView()
            
        } else {
            
            VStack {
                Text("Error")
                    .font(.headline)
                
                Text("Cannot determine sign-in service that is in use when user appears to have been authenticated")
            }
        }
        
    }
}

struct SignOutButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SignOutButtonView()
    }
}
