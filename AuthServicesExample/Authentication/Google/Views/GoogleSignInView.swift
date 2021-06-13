//
//  GoogleSignInView.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-04.
//

import SwiftUI

struct GoogleSignInView: View {
    
    // To allow us to determine color scheme of device
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        
        if colorScheme == .dark {
            
            GoogleSignInButtonDark()
                .frame(width: 210, height: 50, alignment: .center)
                .padding()
                .onTapGesture {
                    GoogleAuthenticationManager().signIn()
                }

        } else {

            GoogleSignInButtonLight()
                .frame(width: 210, height: 50, alignment: .center)
                .padding()
                .onTapGesture {
                    GoogleAuthenticationManager().signIn()
                }

        }
        
        
    }
    
}

struct GoogleSignInView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSignInView()
    }
}
