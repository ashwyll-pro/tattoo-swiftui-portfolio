//
//  MyTattooDiscoveryRemoteSource.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 28/07/2025.
//

import Foundation

struct MyTattooDiscoveryRemoteSource{
    
    func getTattooDiscovery() async throws -> [Discover]{
        guard  let url = URL(string: BaseUrl.getBaseUrl(param: "tattoo")) else {
            print("Invalid input requessts")
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do{
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                       print("Server returned an error: \(httpResponse.statusCode)")
                       throw URLError(.badServerResponse)
                   }
            
            let decoder = JSONDecoder()
                   let dtoList = try decoder.decode([DiscoverDTO].self, from: data)
            return dtoList.map{Discover(from: $0)}
        }catch{
            throw error
        }
    }
    
    func getTattooDiscoveryByTattooStyleID(tattooStyleID: String) async throws -> [DiscoverItem]{
        guard  let url = URL(string: BaseUrl.getBaseUrl(param: "tattoo/\(tattooStyleID)")) else {
            print("Invalid input requessts")
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do{
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                       print("Server returned an error: \(httpResponse.statusCode)")
                       throw URLError(.badServerResponse)
                   }
            
            let decoder = JSONDecoder()
                   let dtoList = try decoder.decode([TattooDTO].self, from: data)
                    
            return dtoList.map{DiscoverItem(from: $0)}
        }catch{
            throw error
        }
    }
}
