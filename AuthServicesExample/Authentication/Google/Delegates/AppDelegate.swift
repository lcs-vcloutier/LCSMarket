//
//  AppDelegate.swift
//  AuthServicesExample
//

//
//  Copyright (c) Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
import UIKit
import GoogleSignIn

//@UIApplicationMain
// [START appdelegate_interfaces]
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // [END appdelegate_interfaces]
    var window: UIWindow?
    
    // GIDSignIn's delegate is a weak property, so we have to define our GoogleAuthenticationDelegate outside the function to prevent it from being deallocated.
    let googleAuthenticationDelegate = GoogleAuthenticationDelegate()

    // [START didfinishlaunching]
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize sign-in
        GIDSignIn.sharedInstance().clientID = GoogleIdentifiers.clientID
        GIDSignIn.sharedInstance().delegate = googleAuthenticationDelegate
        
        return true
    }
    // [END didfinishlaunching]
    
    // [START openurl]
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    // [END openurl]
    
    // [START openurl_new]
    @available(iOS 9.0, *)
    // Called when the sign-in page for Google redirects back to this app
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    // [END openurl_new]
    
}
