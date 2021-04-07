//
//  SharedAuthentication.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-06.
//

import Foundation
import SwiftUI

enum AuthenticationService {
    case apple
    case google
    case undetermined
}

class SharedAuthentication: ObservableObject {
    
    @Published var loggedInWithService: AuthenticationService = .undetermined
    @Published var userName: String = ""
    @Published var userEmail: String = ""

}
