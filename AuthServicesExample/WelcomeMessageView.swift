//
//  WelcomeMessageView.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-06-11.
//

import SwiftUI

// Use this view to present a welcome message and/or image that will appear above sign-in buttons when the user is not authenticated
struct WelcomeMessageView: View {
    
    var body: some View {
        
        VStack {
            
            Text("Please sign in to use the application.")
                .font(.title2)
            
            Image("Authenticate")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
        }
        
    }
}

struct WelcomeMessageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeMessageView()
    }
}
