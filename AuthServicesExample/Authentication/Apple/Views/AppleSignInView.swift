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
    
    // To allow us to determine color scheme of device
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        if colorScheme == .dark {
            
            SignInWithAppleButton(
                onRequest: { request in
                    
                    request.requestedScopes = [.fullName, .email]
                    
                }, onCompletion: { result in

                    handleSignInResult(result: result)

                }
            )
            .frame(width: 200, height: 50, alignment: .center)
            .padding(.top)
            .signInWithAppleButtonStyle(.white)

        } else {
            
            SignInWithAppleButton(
                onRequest: { request in
                    
                    request.requestedScopes = [.fullName, .email]
                    
                }, onCompletion: { result in

                    handleSignInResult(result: result)

                }
            )
            .frame(width: 200, height: 50, alignment: .center)
            .padding(.top)
            .signInWithAppleButtonStyle(.black)
            
        }
        
    }
    
    private func handleSignInResult(result: Result<ASAuthorization, Error>) {
        
        // Handle login result
        switch result {
        
        case .success (let authenticationResults):
            
            // Successful login
            #if DEBUG
            print("DEBUG: ", terminator: "")
            print("Authorization successful! :\(authenticationResults)")
            #endif
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
                
                #if DEBUG
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
                #endif
                
                // NOTE: With Apple Sign-In, the email and name are only provided once, at first "sign up" with the app
                if !email.isEmpty {
                    
                    #if DEBUG
                    print("DEBUG: Saving user data to keychain...")
                    print("--------------------------------------")
                    #endif
                    
                    // Save user info in the device keychain
                    saveItemInKeychain(account: userIdentifierKey, value: userIdentifier)
                    saveItemInKeychain(account: userNameKey, value: name)
                    saveItemInKeychain(account: userEmailKey, value: email)
                    
                    // Get user info from device keychain
                    #if DEBUG
                    print("DEBUG data returned from keychain:")
                    print("----------------------------------")
                    print("userIdentifier is: \(KeychainItem.currentUserIdentifier)")
                    print("email is: \(KeychainItem.currentUserEmail)")
                    print("name is: \(KeychainItem.currentUserName)")
                    #endif
                }
                
            default:
                break
            }
            
        case .failure (let error):
            #if DEBUG
            print("Authorization failed: " + error.localizedDescription)
            #else
            break
            #endif
        }
        
    }
    
    private func saveItemInKeychain(account: String, value: String) {
        do {
            try KeychainItem(service: AppleIdentifiers.bundleID, account: account).saveItem(value)
        } catch {
            #if DEBUG
            print("Unable to save \(account) with value \(value) to keychain.")
            #endif
            
        }
    }
    
}

struct AppleSignInView_Previews: PreviewProvider {
    static var previews: some View {
        AppleSignInView()
    }
}
