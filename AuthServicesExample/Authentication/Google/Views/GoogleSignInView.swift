//
//  GoogleSignInView.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-04.
//

import SwiftUI

struct GoogleSignInView: View {
    
    var body: some View {
        
        GoogleSignInButton()
            .frame(width: 210, height: 50, alignment: .center)
            .padding()
            .onTapGesture {
                GoogleAuthenticationManager().signIn()
            }
        
    }
    
}

struct GoogleSignInView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSignInView()
    }
}
