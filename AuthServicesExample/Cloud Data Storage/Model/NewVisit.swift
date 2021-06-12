//
//  NewVisit.swift
//  AuthServicesExample
//
//  Created by Russell Gordon on 2021-04-07.
//

import Foundation

/*
 This structure is used to write a single row to this spreadsheet:
 
 https://docs.google.com/spreadsheets/d/1RfBwIAdBu7DOSMsOwYJOvcC5o3i7E1z6mBV2ZkEfAjQ/edit#gid=0
 
 ... accessed via this endpoint:
 
 https://api.sheety.co/92d7eb80d996eaeb34616393ebc6ddcf/visitors/rows
 
 */
/// - Tag: add_row_to_spreadsheet
struct NewVisit: Codable {
    
    // NOTE: Sheety requires that the property name be "row"
    let row: Visit

    // Sends the new row to the endpoint
    func encodeAndWriteToEndpoint() throws {
        
        // Create an encoder object
        let encoder = JSONEncoder()
        
        // Ensure generated JSON is easy to read
        encoder.outputFormatting = .prettyPrinted
        
        // Actually encode the data contained within this structure ('self')
        guard let encoded = try? encoder.encode(self) else {
            throw JSONSendError.encodingFailed
        }
        
        // DEBUG: What has been encoded?
        #if DEBUG
        print("Data that will be sent to Sheety is: ")
        print(String(data: encoded, encoding: .utf8)!)
        #endif
    
        // 2. Prepare a URLRequest to send our encoded data as JSON
        let url = URL(string: Visitors.endpoint)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded

        // 3. Run that request and process the response
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Handle result – attempt to unwrap reponse from Sheety service
            guard let responseFromSheety = data else {
                
                // Show the error message
                #if DEBUG
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                #endif
                return
            }
            
            #if DEBUG
            // The response from Sheety...
            // NOTE: If successful, you should see a JSON object that has the row number of the new entry in the spreadsheet
            print("Sheety service response is: \(String(data: responseFromSheety, encoding: .utf8)!)")
            #endif
            
        }.resume()
        
    }
    
}
