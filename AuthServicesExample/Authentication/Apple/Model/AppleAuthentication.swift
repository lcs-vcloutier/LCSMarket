//
//  AppleAuthentication.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-05.
//

import AuthenticationServices
import Foundation
import SwiftUI

enum AppleAuthenticationStatus {
    case signedIn           // User is signed in
    case signedOut          // User explicitly signed out
    case indeterminate      // App closed or backgrouded
}

class AppleAuthentication: ObservableObject {
    
    @Published var userStatus: AppleAuthenticationStatus = .indeterminate
    
    func restoreSignIn() {
        
        // DEBUG
        #if DEBUG
        print("DEBUG: Restoring sign-in with Apple")
        #endif
        
        if userStatus == .indeterminate {
            
            // Check whether app was backgrounded or force quit after explicitly signing out
            let defaults = UserDefaults.standard
            let explicitlySignedOut = defaults.bool(forKey: signedOutKey)
            
            if !explicitlySignedOut {
                
                // Check whether user is already signed in
                let appleIDProvider = ASAuthorizationAppleIDProvider()
                
                appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier,
                                                   completion: { (credentialState, error) in
                    
                    switch credentialState {
                    case .authorized:
                        // The Apple ID credential is valid.
                        DispatchQueue.main.async {
                            
                            self.userStatus = .signedIn
                            
                            // Save to UserDefaults that user is signed in
                            let defaults = UserDefaults.standard
                            defaults.setValue(false, forKey: signedOutKey)

                        }
                    case .revoked, .notFound:
                        DispatchQueue.main.async {
                            self.userStatus = .signedOut
                        }
                    default:
                        break
                    }
                    
                })

            } else {
                
                // User is signed out; must set this so that Google button appears after app is force-quit or backgrounded
                self.userStatus = .signedOut
                
            }

        }
        
    }
    
}
