//
//  AuthenticatedView.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-06.
//

import SwiftUI

// This view is only shown when the user has been authenticated
// Customize as needed – this is the first view the user will see after logging in to your app
/// - Tag: accessing_user_details
struct AuthenticatedView: View {
    
    // Access to shared authentication information
    @EnvironmentObject var sharedAuthenticationStore: SharedAuthentication
    
    // Track user's mood
    @State private var mood: Double = 3
    
    // Obtains data from the spreadsheet
    @StateObject private var dataStore = VisitorsStore()
    
    // How many times has this user shared their mood?
    @State private var moodShareCount = 0
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            Group {
                
                Text("Welcome")
                    .font(.title3)
                    .padding(.top, 20)
                
                // Show user's name
                Text(sharedAuthenticationStore.userName)
                    .font(.title)
                
                // Show user's email
                Text(sharedAuthenticationStore.userEmail)

            }
            
            Group {
                
                // Record my mood
                Text("How are you feeling today?")
                    .bold()
                    .padding(.top)
                HStack {
                    Text("😡")
                        .font(.title)
                    Slider(value: $mood, in: 0...5, step: 1.0) {
                        Text("My mood is...")
                    }
                    Text("🥳")
                        .font(.title)
                }
                
                // Share how I'm feeling
                Button("Save my mood to spreadsheet") {
                    
                    // Send the user information to the spreadsheet
                    saveAndSendUserInformation()
                    
                }
                .padding(.bottom)

            }
            
            Group {
                // How many people have shared their mood?
                Text("Results")
                    .bold()
                    .padding(.top)
                
                Text("\(dataStore.visitors.rows.count + moodShareCount) people have shared their mood.")
            }
            
            // Sign out button for whatever service the user signed in with
            SignOutButtonView()
                .padding(.top)
            
        }
        .padding()
        .onAppear() {
            dataStore.refreshFromRemoteJSONSource()
            moodShareCount = 0
        }
        
    }
    
    func saveAndSendUserInformation() {
        
        // Get current date and time as a string
        // For other formatting options, see:
        // https://developer.apple.com/documentation/foundation/dateformatter
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let now = df.string(from: Date())
        
        // Record user's mood on this visit to the app, for posterity
        let thisVisit = Visit(date: now,
                              name: sharedAuthenticationStore.userName,
                              email: sharedAuthenticationStore.userEmail,
                              mood: Int(mood))
        
        // Set visit information up to be sent to remote spreadsheet
        let newRowInSpreadsheet = NewVisit(row: thisVisit)
        
        // Actually encode and send the user's information
        do {
            try newRowInSpreadsheet.encodeAndWriteToEndpoint()
        } catch JSONSendError.encodingFailed {
            print("DEBUG: Could not encode data to JSON.")
        } catch {
            print("DEBUG: Something else unexpected went wrong.")
        }
        
        // Track times mood has been shared
        moodShareCount += 1
        
        
    }
    
}

struct AuthenticatedView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticatedView()
    }
}
