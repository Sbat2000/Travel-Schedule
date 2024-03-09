//
//  SearchRouteService.swift
//  Travel Schedule
//
//  Created by Aleksandr Garipov on 09.03.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Routes = Components.Schemas.Routes

protocol SearchRouteServiceProtocol {
    func getRoutes(from: String, to: String, limit: Int?) async throws -> Routes
}

final class SearchRouteService: SearchRouteServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getRoutes(from: String, to: String, limit: Int?) async throws -> Routes {
        let response = try await client .getRoutes(query: .init(apikey: apikey, from: from, to: to, limit: limit, transfers: false))
        return try response.ok.body.json
    }
}
