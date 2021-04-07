//
//  AppleSignInView.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-05.
//

import AuthenticationServices
import SwiftUI

struct AppleSignInView: View {
    
    // Access to Apple authentication information
    @EnvironmentObject var appleAuthenticationStore: AppleAuthentication
    
    var body: some View {
        
        SignInWithAppleButton(
            onRequest: { request in
                
                request.requestedScopes = [.fullName, .email]
                
            }, onCompletion: { result in
                
                // Handle login result
                switch result {
                
                case .success (let authenticationResults):
                    
                    // Successful login
                    print("DEBUG: ", terminator: "")
                    print("Authorization successful! :\(authenticationResults)")
                    appleAuthenticationStore.userStatus = .signedIn
                    
                    // Save to UserDefaults that user is signed in
                    let defaults = UserDefaults.standard
                    defaults.setValue(false, forKey: signedOutKey)
                    
                    switch authenticationResults.credential {
                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                        
                        // Get user details
                        let userIdentifier = appleIDCredential.user
                        let fullName = appleIDCredential.fullName
                        let email = appleIDCredential.email ?? ""
                        let name = (fullName?.givenName ?? "") + (" ") + (fullName?.familyName ?? "")
                        
                        print("DEBUG data returned from authentication credential:")
                        print("---------------------------------------------------")
                        print("userIdentifier is: \(userIdentifier)")
                        print("email is: \(email)")
                        print("name is: \(name)")
                        
                        // Get user info from device keychain
                        print("DEBUG data returned from keychain:")
                        print("----------------------------------")
                        print("userIdentifier is: \(KeychainItem.currentUserIdentifier)")
                        print("email is: \(KeychainItem.currentUserEmail)")
                        print("name is: \(KeychainItem.currentUserName)")
                        
                        // NOTE: With Apple Sign-In, the email and name are only provided once, at first "sign up" with the app
                        if !email.isEmpty {
                            
                            print("DEBUG: Saving user data to keychain...")
                            print("--------------------------------------")
                            
                            // Save user info in the device keychain
                            saveItemInKeychain(account: userIdentifierKey, value: userIdentifier)
                            saveItemInKeychain(account: userNameKey, value: name)
                            saveItemInKeychain(account: userEmailKey, value: email)
                            
                            // Get user info from device keychain
                            print("DEBUG data returned from keychain:")
                            print("----------------------------------")
                            print("userIdentifier is: \(KeychainItem.currentUserIdentifier)")
                            print("email is: \(KeychainItem.currentUserEmail)")
                            print("name is: \(KeychainItem.currentUserName)")
                        }
                                                
                    default:
                        break
                    }
                    
                case .failure (let error):
                    print("Authorization failed: " + error.localizedDescription)
                }
                
            }
        )
        .frame(width: 200, height: 50, alignment: .center)
        .padding(.top)
        
    }
    
    private func saveItemInKeychain(account: String, value: String) {
        do {
            try KeychainItem(service: AppleIdentifiers.bundleID, account: account).saveItem(value)
        } catch {
            print("Unable to save \(account) with value \(value) to keychain.")
        }
    }
    
}

struct AppleSignInView_Previews: PreviewProvider {
    static var previews: some View {
        AppleSignInView()
    }
}
