//
//  AuthServicesExampleApp.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-04.
//

import SwiftUI

@main
struct AuthServicesExampleApp: App {
    
    // Create a source of truth for Google Sign-In activity
    // Connect to an instance of the AppDelegate class so that "method swizzling" still works
    // Required because Google Sign-In code was developed for use with UIKit, rather than SwiftUI
    // See: https://medium.com/firebase-developers/firebase-and-the-new-swiftui-2-application-life-cycle-e568c9f744e9
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // Create a source of truth for Apple Sign-In activity
    @StateObject var appleAuthenticationStore = AppleAuthentication()

    // Create a source of truth for overall sign in activity
    @StateObject var sharedAuthenticationStore = SharedAuthentication()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WelcomeView()
                    // Make Google Sign-In information available to other views through the environment
                    .environmentObject(appDelegate.googleAuthenticationDelegate)
                    // Make Apple Sign-In information available to other views through the environment
                    .environmentObject(appleAuthenticationStore)
                    // Make overall sign in information available to other views through the environment
                    .environmentObject(sharedAuthenticationStore)
            }
        }
    }
}
