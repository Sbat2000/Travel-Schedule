//
//  NearestCityService.swift
//  Travel Schedule
//
//  Created by Aleksandr Garipov on 10.03.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestCity = Components.Schemas.City

protocol NearestCityServiceProtocol {
    func getNearestCity(lat: Double, lng: Double, distance: Int) async throws -> NearestCity
}

final class NearestCityService: NearestCityServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    
    func getNearestCity(lat: Double, lng: Double, distance: Int) async throws -> NearestCity {
        let response = try await client.getNearestCity(query: .init(
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
}
