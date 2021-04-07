//
//  WelcomeView.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-04.
//

import SwiftUI

// The first view presented to the user
// Will show sign in buttons when the user is not authenticated
// When the user has been authenticated, shows AuthenticatedView
struct WelcomeView: View {
    
    var body: some View {
        
        VStack {

            SignInButtonsView()
            
            Spacer()
            
        }
        .navigationTitle("Auth Example")
        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
