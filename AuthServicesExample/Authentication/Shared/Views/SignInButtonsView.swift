//
//  SignInButtonsView.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-06.
//

import SwiftUI

struct SignInButtonsView: View {
    
    var body: some View {
        
        AppleAuthenticationView()
        
        GoogleAuthenticationView()

    }
    
}

struct SignInButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        SignInButtonsView()
    }
}
