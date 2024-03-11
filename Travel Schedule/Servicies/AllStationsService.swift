//
//  AllStationsService.swift
//  Travel Schedule
//
//  Created by Aleksandr Garipov on 10.03.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Stations = Components.Schemas.AllStations

protocol AllStationsServiceProtocol {
    func getAllStations() async throws -> HTTPBody
}

final class AllStationsService: AllStationsServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getAllStations() async throws -> HTTPBody {
        let response = try await client.getAllStations(query: .init(
            format: "json"
        ))
        return try response.ok.body.html
    }
}
