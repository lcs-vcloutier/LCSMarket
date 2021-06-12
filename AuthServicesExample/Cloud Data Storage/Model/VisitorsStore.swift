//
//  VisitorsStore.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-07.
//

import Foundation

/*
 An instance of this class will load all rows from this spreadsheet:
 
 https://docs.google.com/spreadsheets/d/1RfBwIAdBu7DOSMsOwYJOvcC5o3i7E1z6mBV2ZkEfAjQ/edit#gid=0
 
 ... accessed via this endpoint:
 
 https://api.sheety.co/92d7eb80d996eaeb34616393ebc6ddcf/visitors/rows
 
 Or optionally, load data from a local JSON file.
 
 */
/// - Tag: load_rows_from_spreadsheet
class VisitorsStore: ObservableObject {
    
    // MARK: Stored properties
    @Published var visitors = Visitors()
    
    // MARK: Initializer
    init(loadFromRemote: Bool = true) {
        
        // By default load from a remote data source
        if loadFromRemote {
            
            refreshFromRemoteJSONSource()

        } else {
            
            // Otherwise load data from a local JSON file to save network traffic and usage of API
            loadFromLocalJSONSource()
            
        }
        
    }
    
    // MARK: Functions
    
    // Populates visitors data from the JSON endpoint
    func refreshFromRemoteJSONSource() {
        
        // 1. Prepare a URLRequest to obtain the list of visitors
        let url = URL(string: Visitors.endpoint)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        // 2. Run the request and process the response
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Handle the result here – attempt to unwrap optional data provided by task
            guard let dataFromSheety = data else {
                
                #if DEBUG
                // Show the error message
                print("No data in response from endpoint: \(error?.localizedDescription ?? "Unknown error")")
                #endif
                
                return
            }
            
            #if DEBUG
            // DEBUG: Print the data received from the Sheety endpoint
            print(String(data: dataFromSheety, encoding: .utf8)!)
            #endif
            
            // Now decode from JSON into an array of Swift native data types
            
            do {
                
                // Attempt to decode the raw JSON data into an instance of the Visitors structure
                let decodedData = try JSONDecoder().decode(Visitors.self, from: dataFromSheety)
                
                #if DEBUG
                // Print a status message to the console
                print("Data decoded from JSON from Sheety API endpoint successfully")
                #endif
                
                // Update the list of visitors on the main thread
                DispatchQueue.main.async {
                    
                    // Set the list of visitors that have been downloaded
                    self.visitors.rows = decodedData.rows
                                            
                }

            } catch {
                
                #if DEBUG
                // Could not decode the JSON
                print("Raw JSON data from endpoint could not be decoded.")
                
                // Print a useful error message
                print(error)
                #endif

            }
                            
        }.resume()
    }
    
    // Populates visitors data from a local file included in app bundle
    func loadFromLocalJSONSource() {
        
        if let url = Bundle.main.url(forResource: "visitors", withExtension: "json") {
            do {
                
                let dataFromAppBundle = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(Visitors.self, from: dataFromAppBundle)
                
                #if DEBUG
                // Print a status message to the console
                print("Successfully decoded data from the JSON file that was obtained from the app bundle")
                #endif
                
                // Set the list of visitors
                self.visitors.rows = decodedData.rows
                                    
            } catch {

                #if DEBUG
                // Could not decode the JSON
                print("Raw JSON data from app bundle could not be decoded.")

                // Print a useful error message
                print(error)
                #endif

            }
        }
    }
    
}

// Create a test store for use with Xcode previews
let testStore = VisitorsStore(loadFromRemote: false)
