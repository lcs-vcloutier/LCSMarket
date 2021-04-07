//
//  AppleUserInfoView.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-05.
//

import SwiftUI

struct AppleUserInfoView: View {
    
    // Access to Apple authentication information
    @EnvironmentObject var appleAuthenticationStore: AppleAuthentication
    
    // Access to shared authentication information
    @EnvironmentObject var sharedAuthenticationStore: SharedAuthentication
    
    var body: some View {
        
        AuthenticatedView()
            .onAppear() {
                sharedAuthenticationStore.loggedInWithService = .apple
                sharedAuthenticationStore.userName = KeychainItem.currentUserName
                sharedAuthenticationStore.userEmail = KeychainItem.currentUserEmail
            }
        
    }
}

struct AppleUserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AppleUserInfoView()
    }
}
