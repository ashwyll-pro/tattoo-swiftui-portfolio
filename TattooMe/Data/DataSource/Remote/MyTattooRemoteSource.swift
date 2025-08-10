//
//  MyTattooRemoteSource.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 05/07/2025.
//

import Foundation

struct MyTattooRemoteSource{
    
    func getMyTattooByPrompt(prompt: Prompt) async throws -> MyTattooDTO {
    
        guard  let url = URL(string: BaseUrl.getBaseUrl()), !prompt.promptText.isEmpty, !prompt.tattooStyle.isEmpty else {
            print("Invalid input requessts")
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(prompt)
        } catch {
            print("URL error: \(error.localizedDescription)")
            throw error // propagate encoding error
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            print("data :: \(data)")
            
            // Optional: Check HTTP response status
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                print("response URL error:")
                throw URLError(.badServerResponse)
            }

            let tattoo = try JSONDecoder().decode(MyTattooDTO.self, from: data)
            return tattoo
            
        } catch {
            print("URL session error: \(error.localizedDescription)")
            throw error // propagate any network or decoding error
        }
    }
}
