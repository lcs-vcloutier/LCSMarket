//
//  GoogleAuthenticationDelegate.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-04.
//

import Foundation
import GoogleSignIn

class GoogleAuthenticationDelegate: NSObject, GIDSignInDelegate, ObservableObject {
    
    @Published var signedIn: Bool = false
    
    // [START signin_handler]
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                #if DEBUG
                print("The user has not signed in before or they have since signed out.")
                #endif
            } else {
                #if DEBUG
                print("\(error.localizedDescription)")
                #endif
            }
            
            // [START_EXCLUDE silent]
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
            // [END_EXCLUDE]
            
            return
        }
        
        // If the previous `error` is null, then the sign-in was succesful
        #if DEBUG
        print("Successful sign-in!")
        #endif
        signedIn = true
        
        // [START_EXCLUDE]
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "ToggleAuthUINotification"),
            object: nil,
            userInfo: ["statusText": "Signed in user:\n\(user.profile.name!)"])
        // [END_EXCLUDE]
        
    }
    
    // [START disconnect_handler]
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // [START_EXCLUDE]
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "ToggleAuthUINotification"),
            object: nil,
            userInfo: ["statusText": "User has disconnected."])
        // [END_EXCLUDE]
    }
    // [END disconnect_handler]
}
