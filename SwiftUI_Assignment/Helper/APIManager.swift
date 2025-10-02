//
//
//  APIManager.swift
//  SwiftUI_Assignment
//
//  Created by Ankit on 02/10/25.
//

import Foundation

class APIManager {
    
   
    static let shared = APIManager()
    
    func fetchData<T: Decodable>(
        from urlString: String,
        modelType: T.Type
    ) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NSError(
                domain: "APIManager",
                code: 1001,
                userInfo: [NSLocalizedDescriptionKey: "Invalid URL: \(urlString)"]
            )
        }
        
        do {
           
            let (data, response) = try await URLSession.shared.data(from: url)
         
            if let httpResponse = response as? HTTPURLResponse {
                guard (200...299).contains(httpResponse.statusCode) else {
                    throw NSError(
                        domain: "APIManager",
                        code: httpResponse.statusCode,
                        userInfo: [NSLocalizedDescriptionKey: "HTTP Error: Status code \(httpResponse.statusCode)"]
                    )
                }
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📩 Raw API Response:\n\(jsonString)\n")
            } else {
                print("⚠️ Could not convert data to string.")
            }
            
           
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
            
        } catch let urlError as URLError {
            
            throw NSError(
                domain: "APIManager",
                code: urlError.errorCode,
                userInfo: [NSLocalizedDescriptionKey: "Network error: \(urlError.localizedDescription)"]
            )
        } catch {
           
            throw NSError(
                domain: "APIManager",
                code: 1004,
                userInfo: [NSLocalizedDescriptionKey: "Fetching or decoding failed: \(error.localizedDescription)"]
            )
        }
    }
    
}
